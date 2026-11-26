require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    @user = users(:one)
  end

  test "should get index without authentication" do
    get posts_url
    assert_response :success
  end

  test "should show post without authentication" do
    get post_url(@post)
    assert_response :success
  end

  test "should redirect new to login when not authenticated" do
    get new_post_url
    assert_redirected_to new_user_session_url
  end

  test "should redirect create to login when not authenticated" do
    assert_no_difference("Post.count") do
      post posts_url, params: { post: { content: @post.content, title: @post.title } }
    end
    assert_redirected_to new_user_session_url
  end

  test "should redirect edit to login when not authenticated" do
    get edit_post_url(@post)
    assert_redirected_to new_user_session_url
  end

  test "should redirect destroy to login when not authenticated" do
    assert_no_difference("Post.count") do
      delete post_url(@post)
    end
    assert_redirected_to new_user_session_url
  end

  test "should get new when authenticated" do
    sign_in @user
    get new_post_url
    assert_response :success
  end

  test "should create post when authenticated" do
    sign_in @user
    assert_difference("Post.count") do
      post posts_url, params: { post: { content: @post.content, title: @post.title } }
    end
    assert_redirected_to post_url(Post.last)
  end

  test "should create post with attachments" do
    sign_in @user
    assert_difference([ "Post.count", "ActiveStorage::Attachment.count" ]) do
      post posts_url, params: {
        post: {
          title: "Story with files",
          content: "Attached body",
          attachments: [ fixture_file_upload("sample.txt", "text/plain") ]
        }
      }
    end
    assert_equal 1, Post.last.attachments.count
  end

  test "should add an attachment when updating" do
    sign_in @user
    assert_difference("ActiveStorage::Attachment.count") do
      patch post_url(@post), params: {
        post: {
          title: @post.title,
          content: @post.content,
          attachments: [ fixture_file_upload("sample.txt", "text/plain") ]
        }
      }
    end
    assert_redirected_to post_url(@post)
  end

  test "should list attachments on the post page" do
    @post.attachments.attach(io: file_fixture("sample.txt").open, filename: "notes.txt", content_type: "text/plain")
    get post_url(@post)
    assert_response :success
    assert_includes response.body, "notes.txt"
    assert_includes response.body, "Attachments"
  end

  test "should get edit when authenticated" do
    sign_in @user
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post when authenticated" do
    sign_in @user
    patch post_url(@post), params: { post: { content: @post.content, title: @post.title } }
    assert_redirected_to post_url(@post)
  end

  test "should destroy post when authenticated" do
    sign_in @user
    assert_difference("Post.count", -1) do
      delete post_url(@post)
    end
    assert_redirected_to posts_url
  end
end
