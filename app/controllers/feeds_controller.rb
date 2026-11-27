class FeedsController < ApplicationController
  def rss
    @posts = Post.published.recent.limit(20)
    respond_to do |format|
      format.rss { render layout: false }
      format.xml { render layout: false }
    end
  end

  def sitemap
    @posts = Post.published.recent
    @categories = Category.all
    @tags = Tag.all
    respond_to do |format|
      format.xml { render layout: false }
    end
  end
end
