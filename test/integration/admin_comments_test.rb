require "test_helper"

class AdminCommentsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in admin_users(:one), scope: :admin_user
  end

  test "lists public comments" do
    get admin_comments_path
    assert_response :success
    assert_includes response.body, comments(:one).body
  end

  test "creates a public comment that shows on the post page" do
    assert_difference("Comment.count") do
      post admin_comments_path, params: {
        comment: { body: "From the admin panel", post_id: posts(:one).id, user_id: users(:one).id }
      }
    end

    comment = Comment.last
    assert_redirected_to admin_comment_path(comment)

    get post_path(comment.post)
    assert_response :success
    assert_includes response.body, "From the admin panel"
  end

  test "post show page lists public comments" do
    get admin_post_path(posts(:one))
    assert_response :success
    assert_includes response.body, "Public comments"
  end
end
