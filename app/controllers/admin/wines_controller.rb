class Admin::WinesController < ApplicationController
  
  def index
    @wines = Wine.all
    @genres = Genre.all
  end
  
  def myindex
    @member = Member.find(params[:id])
    @wines = @member.wines.all
    @genres = Genre.all
  end
  
  def show
    @wine = Wine.find(params[:id])
    @comment = Comment.new
  end
  
  def edit
    @wine = Wine.find(params[:id])
    @spot = @wine.spot
  end
  
  def destroy
    wine = Wine.find(params[:id])
    wine.destroy
    redirect_to wines_path
  end
  
  private

  def wine_params
    params.require(:wine).permit(:member_id, :genre_id, :spot_id, :wine_name, :production_country, :production_year, :rate, :impression, :is_again, :wine_image)
  end

  def member_params
    params.require(:member).permit(:name, :profile_image, :favorite_genre, :prefecture, :introduction, :is_deleted)
  end
  
  def spot_params
    params.require(:spot).permit(:spot_name, :address, :telephone_number, :lat, :lng)
  end
end
