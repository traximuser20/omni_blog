class Category < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    [ "id", "name", "slug", "description", "created_at", "updated_at" ]
  end
  def self.ransackable_associations(auth_object = nil)
    [ "posts" ]
  end
  has_many :posts, dependent: :nullify

  validates :name, presence: true, length: { maximum: 100 }
  validates :slug, presence: true, length: { maximum: 100 }, uniqueness: true

  before_validation :generate_slug

  def to_param
    slug
  end

  def to_s
    name
  end

  private

  def generate_slug
    return if slug.present?
    self.slug = name.to_s.parameterize
  end
end
