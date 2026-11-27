class CategoriesController < ApplicationController
  def index
    @categories = Category.order(:name)
  end

  def show
    @category = Category.find_by!(slug: params[:slug])
    @posts = @category.posts.published.recent.includes(:tags)
  end
end
