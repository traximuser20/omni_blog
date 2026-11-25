class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  # Handle stale sessions that were serialized with extra arguments
  # (e.g., when :trackable was previously enabled and stored 4 elements).
  # Devise 5.0 serialize_from_session expects exactly (key, salt).
  def self.serialize_from_session(key, salt, *_extra)
    super(key, salt)
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "email", "sign_in_count", "current_sign_in_at", "last_sign_in_at", "created_at", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
