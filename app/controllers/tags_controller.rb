class TagsController < ApplicationController
  def index
    @tags = Tag.order(:name)
  end

  def show
    @tag = Tag.find_by!(slug: params[:slug])
    @posts = @tag.posts.published.recent.includes(:category)
  end
end
