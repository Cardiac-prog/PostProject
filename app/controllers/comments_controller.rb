class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
     if @comment.save
       redirect_to post_path(@post), notice: "Comment was successfully created."
     else
       redirect_to post_path(@post), alert: "Comment could not be created."
     end
  end


  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize @comment  # Pundit authorization
  end

  def update
  @post = Post.find(params[:post_id])
  @comment = @post.comments.find(params[:id])
  authorize @comment  # Pundit authorization

    # if can?(:update, @comment)
    if @comment.update(comment_params)
      redirect_to post_path(@post), notice: "Comment was successfully updated."
    else
      redirect_to post_path(@post), alert: "Comment could not be updated."
    end
  # else
  # redirect_to post_path(@post), notice: "You can't access this."
  # end
end


  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize @comment  # Pundit authorization
      # if can?(:destroy, @comment)

      if @comment.destroy
      redirect_to post_path(@post), status: :see_other, notice: "Comment was successfully destroyed."
      else
      redirect_to post_path(@post), alert: "You can't destroy this comment."
      end
    # else
    # redirect_to post_path, notice: "You can't destroy this comment."
    # end
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
