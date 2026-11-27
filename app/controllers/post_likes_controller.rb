class PostLikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    current_user.post_likes.find_or_create_by(post: @post)
    redirect_back fallback_location: @post, notice: "Liked."
  end

  def destroy
    current_user.post_likes.find_by(post: @post)&.destroy
    redirect_back fallback_location: @post, notice: "Unliked."
  end

  private

  def set_post
    @post = Post.find_by(slug: params[:slug]) || Post.find(params[:slug])
  end
end
