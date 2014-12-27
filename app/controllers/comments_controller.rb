class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new(:parent_id => params[:parent_id], :post_id => params[:post_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create!(comment_params) if current_user
    @comment.user = current_user
    @comment.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if (current_user == @comment.user)
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
