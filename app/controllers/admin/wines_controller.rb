class Admin::WinesController < ApplicationController
  
  def index
    @wines = Wine.includes(:member).where(member: { is_deleted: false })
    @genres = Genre.all
  end
  
  def myindex
    @member = Member.find(params[:id])
    @wines = @member.wines.all
    @genres = Genre.all
  end
  
  def again_index
    @member = Member.find(params[:id])
    @wines = @member.wines.all
    @again_wines = @wines.where(is_again: true)
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
  
  def update
    @wine = Wine.find(params[:id])
    if @wine.update(wine_params)
      flash[:notice] = "ナチュール投稿の更新が完了しました。"
      redirect_to admin_wine_path(@wine.id)
    else
      flash[:error] = "※情報が足りません"
      render :edit
    end
  end
  
  def destroy
    wine = Wine.find(params[:id])
    if wine.destroy
      flash[:notice] = "削除が完了しました。"
      redirect_to admin_wines_path
    else
      flash[:error] = "削除が完了できていません。"
      render :show
    end
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
