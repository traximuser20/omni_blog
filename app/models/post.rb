class Post < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :category, optional: true
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :post_likes, dependent: :destroy
  has_many :liked_users, through: :post_likes, source: :user
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_users, through: :bookmarks, source: :user
  has_many_attached :attachments
  has_one_attached :cover_image

  validates :title, presence: true, length: { maximum: 120 }
  validates :content, presence: true
  validates :status, inclusion: { in: %w[draft published] }
  validates :slug, uniqueness: true, allow_blank: true
  validate :attachments_within_limits

  before_validation :generate_slug, on: :create
  before_save :set_published_at

  scope :published, -> { where(status: "published") }
  scope :drafts, -> { where(status: "draft") }
  scope :recent, -> { order(created_at: :desc) }
  scope :by_category, ->(slug) { joins(:category).where(categories: { slug: slug }) }
  scope :by_tag, ->(slug) { joins(:tags).where(tags: { slug: slug }) }
  scope :search, ->(q) {
    return all if q.blank?
    pattern = "%#{ActiveRecord::Base.sanitize_sql_like(q)}%"
    left_joins(:tags, :category).where(
      "posts.title ILIKE ? OR posts.excerpt ILIKE ? OR posts.content ILIKE ? OR tags.name ILIKE ? OR categories.name ILIKE ?",
      pattern, pattern, pattern, pattern, pattern
    ).distinct
  }

  def to_param
    slug.presence || id.to_s
  end

  def published?
    status == "published"
  end

  def reading_time
    words = content.to_s.split.size
    [ (words / 200.0).ceil, 1 ].max
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "title", "content", "status", "slug", "created_at", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "category", "tags", "comments", "user" ]
  end

  private

  def generate_slug
    return if slug.present?
    base = title.to_s.parameterize
    return if base.blank?
    candidate = base
    i = 2
    while Post.exists?(slug: candidate)
      candidate = "#{base}-#{i}"
      i += 1
    end
    self.slug = candidate
  end

  def set_published_at
    if status == "published" && published_at.nil?
      self.published_at = Time.current
    end
    if status == "draft"
      self.published_at = nil
    end
  end

  def attachments_within_limits
    if attachments.size > 10
      errors.add(:attachments, "can include at most 10 files")
    end

    attachments.each do |attachment|
      next if attachment.blob.byte_size <= 10.megabytes
      errors.add(:attachments, "must be 10 MB or smaller each")
    end
  end
end
