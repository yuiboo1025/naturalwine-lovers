class Public::BookmarksController < ApplicationController
  before_action :authenticate_member!
  
  def create
    @wine = Wine.find(params[:wine_id])
    bookmark = current_member.bookmarks.new(wine_id: @wine.id)
    bookmark.save
  end

  def destroy
    @wine = Wine.find(params[:wine_id])
    bookmark = current_member.bookmarks.find_by(wine_id: @wine.id)
    bookmark.destroy
  end
end
