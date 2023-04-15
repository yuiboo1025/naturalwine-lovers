class Public::CommentsController < ApplicationController
  before_action :authenticate_member!
  
  def create
    @wine = Wine.find(params[:wine_id])
    @comment = current_member.comments.new(comment_params)
    @comment.wine_id = @wine.id
    @comment.save
    @comment = Comment.new
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    @comment = Comment.new
    @wine = Wine.find(params[:wine_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:wine_id, :member_id, :comment)
  end

end
