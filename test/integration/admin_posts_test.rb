require "test_helper"

class AdminPostsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in admin_users(:one), scope: :admin_user
  end

  test "renders the posts index for an authenticated admin" do
    get admin_posts_path
    assert_response :success
    assert_select "title", text: /Posts/
  end

  test "renders the new post form for an authenticated admin" do
    get new_admin_post_path
    assert_response :success
  end

  test "renders the post detail page for an authenticated admin" do
    get admin_post_path(posts(:one))
    assert_response :success
  end

  test "renders the edit post form for an authenticated admin" do
    get edit_admin_post_path(posts(:one))
    assert_response :success
  end
end
