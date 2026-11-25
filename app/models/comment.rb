class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :body, presence: true, length: { maximum: 2_000 }

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "body", "post_id", "user_id", "created_at", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "post", "user" ]
  end
end
