require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    @user = users(:one)
  end

  test "should require authentication to create comment" do
    assert_no_difference("Comment.count") do
      post post_comments_url(@post), params: { comment: { body: "Anonymous" } }
    end
    assert_redirected_to new_user_session_url
  end

  test "should create comment for signed in user" do
    sign_in @user

    assert_difference("Comment.count") do
      post post_comments_url(@post), params: { comment: { body: "Loved this one." } }
    end

    assert_redirected_to post_url(@post)
    assert_equal users(:one), Comment.last.user
    follow_redirect!
    assert_response :success
    assert_includes response.body, "Loved this one."
  end

  test "should not create blank comment" do
    sign_in @user

    assert_no_difference("Comment.count") do
      post post_comments_url(@post), params: { comment: { body: "" } }
    end
    assert_redirected_to post_url(@post)
  end

  test "author should delete own comment" do
    sign_in @user

    assert_difference("Comment.count", -1) do
      delete post_comment_url(@post, @comment)
    end
    assert_redirected_to post_url(@post)
  end

  test "should not delete another user's comment" do
    sign_in users(:two)

    assert_no_difference("Comment.count") do
      delete post_comment_url(@post, @comment)
    end
    assert_redirected_to post_url(@post)
  end