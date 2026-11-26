require "test_helper"

class AttachmentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    @user = users(:one)
    @post.attachments.attach(io: file_fixture("sample.txt").open, filename: "sample.txt", content_type: "text/plain")
    @attachment = @post.attachments.first
  end

  test "should redirect to login when not authenticated" do
    assert_no_difference("ActiveStorage::Attachment.count") do
      delete post_attachment_url(@post, @attachment)
    end
    assert_redirected_to new_user_session_url
  end

  test "should purge an attachment when authenticated" do
    sign_in @user
    assert_difference("ActiveStorage::Attachment.count", -1) do
      delete post_attachment_url(@post, @attachment)
    end
    assert_redirected_to edit_post_url(@post)
    assert_equal "Attachment removed.", flash[:notice]
  end
end
