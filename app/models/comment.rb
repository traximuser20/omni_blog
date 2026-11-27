class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :body, presence: true, length: { maximum: 2_000 }
  validates :status, inclusion: { in: %w[pending approved] }

  scope :approved, -> { where(status: "approved") }
  scope :pending, -> { where(status: "pending") }

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "body", "post_id", "user_id", "status", "created_at", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "post", "user" ]
  end
end
