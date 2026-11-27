class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def destroy
    attachment = @post.attachments.find(params[:id])
    attachment.purge

    redirect_to edit_post_path(@post), notice: "Attachment removed.", status: :see_other
  end

  private
    def set_post
      @post = Post.find_by(slug: params[:slug]) || Post.find(params[:slug]) rescue Post.find(params[:post_id])
    end
end
