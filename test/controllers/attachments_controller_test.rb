require "test_helper"

class AttachmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @post.attachments.attach(io: file_fixture("sample.txt").open, filename: "sample.txt", content_type: "text/plain")
    @attachment = @post.attachments.first
  end

  test "should purge an attachment" do
    assert_difference("ActiveStorage::Attachment.count", -1) do
      delete post_attachment_url(@post, @attachment)
    end

    assert_redirected_to edit_post_url(@post)
    assert_equal "Attachment removed.", flash[:notice]
  end
end
