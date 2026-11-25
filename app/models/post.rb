class Post < ApplicationRecord
  has_many_attached :attachments

  validate :attachments_within_limits

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "title", "content", "created_at", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  has_many :comments, dependent: :destroy

  private
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
