require "test_helper"

class CommentTest < ActiveSupport::TestCase
  setup do
    @post = posts(:one)
    @user = users(:one)
  end

  test "is valid with a body, post and user" do
    assert Comment.new(body: "Nice post", post: @post, user: @user).valid?
  end

  test "requires a body" do
    comment = Comment.new(body: " ", post: @post, user: @user)

    assert_not comment.valid?
    assert_includes comment.errors[:body], "can't be blank"
  end

  test "limits body length" do
    comment = Comment.new(body: "a" * 2_001, post: @post, user: @user)

    assert_not comment.valid?
  end
end
