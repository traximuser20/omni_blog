class SearchController < ApplicationController
  def index
    @query = params[:q].to_s
    @posts = Post.published.search(@query).recent.includes(:category, :tags)
  end
end
