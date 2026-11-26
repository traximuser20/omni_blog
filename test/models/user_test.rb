require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "is valid with an email and password" do
    user = User.new(email: "new@example.com", password: "password123", password_confirmation: "password123")
    assert user.valid?
  end

  test "requires an email" do
    user = User.new(email: "", password: "password123", password_confirmation: "password123")
    assert_not user.valid?
  end

  test "requires a unique email" do
    existing = users(:one)
    user = User.new(email: existing.email, password: "password123", password_confirmation: "password123")
    assert_not user.valid?
  end
end
