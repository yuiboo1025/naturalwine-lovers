class Public::FavoritesController < ApplicationController

  def create
    @wine = Wine.find(params[:wine_id])
    favorite = current_member.favorites.new(wine_id: @wine.id)
    favorite.save
    #redirect_to wine_path(wine)
  end

  def destroy
    @wine = Wine.find(params[:wine_id])
    favorite = current_member.favorites.find_by(wine_id: @wine.id)
    favorite.destroy
    #redirect_to wine_path(wine)
  end
end
