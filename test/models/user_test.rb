require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "is valid with an email and password" do
    user = User.new(email: "new@example.com", password: "password123", password_confirmation: "password123")
    assert user.valid?
  end

  test "requires an email" do
    user = User.new(email: "", password: "password123", password_confirmation: "password123")
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "requires a unique email" do
    existing = users(:one)
    user = User.new(email: existing.email, password: "password123", password_confirmation: "password123")
    assert_not user.valid?
    assert_includes user.errors[:email], "has already been taken"
  end

  test "requires password confirmation to match" do
    user = User.new(email: "test@example.com", password: "password123", password_confirmation: "different")
    assert_not user.valid?
    assert_includes user.errors[:password_confirmation], "doesn't match Password"
  end

  test "validates password minimum length" do
    user = User.new(email: "test@example.com", password: "short", password_confirmation: "short")
    assert_not user.valid?
    assert_includes user.errors[:password], "is too short (minimum is 6 characters)"
  end

  test "validates email format" do
    user = User.new(email: "not-an-email", password: "password123", password_confirmation: "password123")
    assert_not user.valid?
    assert user.errors[:email].any?
  end

  test "has many comments" do
    assert_respond_to users(:one), :comments
  end
end
