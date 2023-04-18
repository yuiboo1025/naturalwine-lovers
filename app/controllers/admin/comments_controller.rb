class Admin::CommentsController < ApplicationController
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
