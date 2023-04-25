class Admin::SpotsController < ApplicationController
  
  def index
    #spotテーブルとwineテーブルを結合して、wineの情報があるものだけ取ってきている
    #結合すると、wineの個数分spotのレコードができてしまうので、uniqで重複削除をしている
    @spots = Spot.joins(:wines).all.uniq
  end

  def show
    @spot = Spot.find(params[:id])
    @wines = @spot.wines.all
    @genres = Genre.all
  end

  def edit
    @spot = Spot.find(params[:id])
  end

  def update
    #編集からワインを取ってくる
    @wine = Wine.find(params[:spot][:wine_id])
    #編集画面で入力した緯度経度からspotを検索
    spot = Spot.where(lat: params[:spot][:lat]).where(lng: params[:spot][:lng]).first
    #spotが存在すれば
    if spot.blank?
      #新しいspotを作成
      spot = Spot.new(spot_params)
      spot.save
       #wineを更新をする(カラム名：↑で作成されたspotのid)
      @wine.update(spot_id: spot.id)
    #spotが存在しなければ
    else
      #同じとこをろ探す
      spot = Spot.where(lat: params[:spot][:lat]).where(lng: params[:spot][:lng]).first
      #wineを更新をする(カラム名：↑で検索されたspotのid)
      @wine.update(spot_id: spot.id)
    end
    redirect_to edit_admin_wine_path(params[:spot][:wine_id])
  end


  private

  def spot_params
    params.require(:spot).permit(:spot_name, :address, :telephone_number, :lat, :lng)
  end
  
end
