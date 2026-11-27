class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[ create destroy ]
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    @comment.status = "approved"

    if @comment.save
      redirect_to @post, notice: "Comment posted.", status: :see_other
    else
      redirect_to @post, alert: @comment.errors.full_messages.to_sentence, status: :see_other
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    if @comment.user == current_user || (respond_to?(:current_admin_user) && current_admin_user)
      @comment.destroy!
      redirect_to @post, notice: "Comment deleted.", status: :see_other
    else
      redirect_to @post, alert: "You can only delete your own comments.", status: :see_other
    end
  end

  private
    def set_post
      @post = Post.find_by(slug: params[:slug]) || Post.find(params[:slug]) rescue Post.find(params[:post_id])
    end

    def comment_params
      params.expect(comment: [ :body ])
    end
end
