class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[ new create edit update destroy ]
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    per_page = 9
    page = [ params[:page].to_i, 1 ].max
    scope = Post.published.recent.includes(:category, :tags, :user)
    @total = scope.count
    @posts = scope.offset((page - 1) * per_page).limit(per_page)
    @page = page
    @per_page = per_page
    @total_pages = (@total.to_f / per_page).ceil
  end

  def show
    @comments = @post.comments.includes(:user).order(created_at: :asc)
    @comment = Comment.new(post: @post)
    @related = Post.published.where.not(id: @post.id).order(created_at: :desc).limit(3)
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user if user_signed_in?

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @post.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @post.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, notice: "Post was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find_by(slug: params[:slug]) || Post.find(params[:slug])
  rescue ActiveRecord::RecordNotFound
    @post = Post.find(params[:slug])
  end

  def post_params
    params.expect(post: [ :title, :content, :subtitle, :excerpt, :status, :category_id, :seo_title, :seo_description, tag_ids: [], attachments: [], cover_image: nil ])
  end
end
