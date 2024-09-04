class Api::V1::PostsController < ApplicationController
skip_before_action :verify_authenticity_token, only: [ :create, :update, :destroy ]
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_post, only: [ :edit, :update, :destroy ]
  before_action :authenticate_user!, unless: -> { Rails.env.test? }

  def index
    if params[:query].present?
      @pagy, @posts = pagy(Post.search_posts(params[:query]))
    else
      @pagy, @posts = pagy(Post.all)
    end
    render json: @posts
  end

  def show
    render json: @post
  end

  def create
  if current_user
    @post = current_user.posts.new(post_params)

    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  else
    render json: { error: "User not authenticated" }, status: :unauthorized
  end
  end
  def edit
    # @post = Post.find(params[:id])
    authorize @post      # Pundit authorization
  end
  def update
    authorize @post
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @post
    @post.destroy
    head :no_content
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_post
    authorize @post
  end

  def post_params
    params.require(:post).permit(:title, :content, :category)
  end
end
