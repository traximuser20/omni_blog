class Bookmark < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    [ "id", "created_at", "updated_at" ]
  end
  belongs_to :user
  belongs_to :post
  validates :user_id, uniqueness: { scope: :post_id }
end
