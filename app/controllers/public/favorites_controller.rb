class Public::FavoritesController < ApplicationController
  before_action :authenticate_member!

  def create
    @wine = Wine.find(params[:wine_id])
    favorite = current_member.favorites.new(wine_id: @wine.id)
    favorite.save
  end

  def destroy
    @wine = Wine.find(params[:wine_id])
    favorite = current_member.favorites.find_by(wine_id: @wine.id)
    favorite.destroy
  end
end
