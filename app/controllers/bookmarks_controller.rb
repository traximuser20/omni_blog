class BookmarksController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_post, only: %i[create destroy]

  def index
    @posts = current_user.bookmarked_posts.published.recent.includes(:category, :tags)
  end

  def create
    current_user.bookmarks.find_or_create_by(post: @post)
    redirect_back fallback_location: @post, notice: "Bookmarked."
  end

  def destroy
    current_user.bookmarks.find_by(post: @post)&.destroy
    redirect_back fallback_location: @post, notice: "Bookmark removed."
  end

  private

  def set_post
    @post = Post.find_by(slug: params[:slug]) || Post.find(params[:slug])
  end
end
