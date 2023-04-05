class Public::CommentsController < ApplicationController
  def create
    wine = Wine.find(params[:wine_id])
    comment = current_member.comments.new(comment_params)
    comment.wine_id = wine.id
    comment.save
    redirect_to wine_path(wine)
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to wine_path(params[:wine_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:wine_id, :member_id, :comment)
  end

end
