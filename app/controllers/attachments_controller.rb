class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  # DELETE /posts/:post_id/attachments/:id
  def destroy
    attachment = @post.attachments.find(params.expect(:id))
    attachment.purge

    redirect_to edit_post_path(@post), notice: "Attachment removed.", status: :see_other
  end

  private
    def set_post
      @post = Post.find(params.expect(:post_id))
    end
end
