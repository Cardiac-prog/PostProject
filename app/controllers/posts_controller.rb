class PostsController < ApplicationController
# rescue_from CanCan::AccessDenied do |exception|
#   redirect_back fallback_location: root_path, alert: exception.message
# end
before_action :set_post, only: [ :edit, :update, :destroy ]
   before_action :authorize_post, only: [ :edit, :update, :destroy ]
  def index
    if params[:query].present?
      @pagy, @posts = pagy(Post.search_posts(params[:query]))
    else
      @pagy, @posts = pagy(Post.all)
    end
    # @pagy, @posts = pagy(Post.all)
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
    # @post = Post.find(params[:id])
    authorize @post      # Pundit authorization
  end

  def update
    # @post = Post.find(params[:id])
    authorize @post      # Pundit authorization
      # if can?(:update, @post)       Cancan
      if @post.update(post_params)

        redirect_to root_path, status: :see_other
      else
        render :edit, status: :unprocessable_entity
      end
    #  else
    # redirect_to root_path, notice:  "You can't access this."
    # end
  end

  def destroy
     # @post = Post.find(params[:id])
     # if can?(:destroy, @post)
     authorize @post      # Pundit authorization

      @post.destroy

      redirect_to root_path, notice: "Post was successfully destroyed."
    #  else          Cancan

    #  redirect_to root_path, notice: "You can't destroy this post."      Cancan
    #  end      Cancan
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_post
    authorize @post
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :category)
  end
end
