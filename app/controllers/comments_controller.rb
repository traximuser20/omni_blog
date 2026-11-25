class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  # POST /posts/:post_id/comments
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: "Comment posted.", status: :see_other
    else
      redirect_to @post, alert: @comment.errors.full_messages.to_sentence, status: :see_other
    end
  end

  # DELETE /posts/:post_id/comments/:id
  def destroy
    @comment = @post.comments.find(params.expect(:id))

    if @comment.user == current_user
      @comment.destroy!
      redirect_to @post, notice: "Comment deleted.", status: :see_other
    else
      redirect_to @post, alert: "You can only delete your own comments.", status: :see_other
    end
  end

  private
    def set_post
      @post = Post.find(params.expect(:post_id))
    end

    def comment_params
      params.expect(comment: [ :body ])
    end
end
