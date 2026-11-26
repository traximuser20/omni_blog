require "test_helper"

class AdminUserTest < ActiveSupport::TestCase
  test "is valid with an email and password" do
    admin = AdminUser.new(email: "admin2-new@example.com", password: "password123", password_confirmation: "password123")
    assert admin.valid?
  end

  test "requires an email" do
    admin = AdminUser.new(email: "", password: "password123", password_confirmation: "password123")
    assert_not admin.valid?
  end

  test "requires a unique email" do
    existing = admin_users(:one)
    admin = AdminUser.new(email: existing.email, password: "password123", password_confirmation: "password123")
    assert_not admin.valid?
  end
end
