require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference("Post.count") do
      post posts_url, params: { post: { content: @post.content, title: @post.title } }
    end

    assert_redirected_to post_url(Post.last)
  end

  test "should create post with attachments" do
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

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: { post: { content: @post.content, title: @post.title } }
    assert_redirected_to post_url(@post)
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
