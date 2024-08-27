class PostsController < ApplicationController
  # rescue_from CanCan::AccessDenied do |exception|
  #   redirect_back fallback_location: root_path, alert: exception.message
  # end

  # before_action :authorize_post, only: [ :edit, :update, :destroy ]
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post =  current_user.posts.new(post_params)

    if @post.save
      redirect_to root_path, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if can?(:update, @post)
      if @post.update(post_params)

        redirect_to root_path, status: :see_other
      else
        render :edit, status: :unprocessable_entity
      end
    else
  redirect_to root_path, notice:  "You can't access this."
    end
  end

  def destroy
      @post = Post.find(params[:id])
      if can?(:destroy, @post)

      @post.destroy

      redirect_to root_path, notice: "Post was successfully destroyed."
      else
      redirect_to root_path, notice: "You can't destroy this post."
      end
  end

  def authorize_post
    authorize! :manage, @post
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :category)
  end
end
