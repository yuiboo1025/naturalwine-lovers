class Admin::SpotsController < ApplicationController

  def index
   #退会しているメンバーの投稿情報は表示させない
    member = Member.where(is_deleted: false)
    #spotテーブルとwineテーブルを結合して、wineの情報があるものだけ取ってきている
    #結合すると、wineの個数分spotのレコードができてしまうので、uniqで重複削除をしている
    @spots = Spot.joins(:wines).where(wines: {member_id: member}).all.uniq
  end

  def spots_list
    @spots_list = Spot.all
  end

  def show
    @spot = Spot.find(params[:id])
    @wines = @spot.wines.order(id: "DESC")
    @genres = Genre.all
  end

  def edit
    @spot = Spot.find(params[:id])
  end

  def update
    #編集からワインを取ってくる
    @wine = Wine.find(params[:spot][:wine_id])
    #過去のspotの情報を＠wineから取得
    spot = @wine.spot
    #spotと、paramsから送られたspotのaddressのデータが一致しない場合
    if spot.address != params[:spot][:address]
      if Spot.exists?(address: params[:spot][:address])
        spot = Spot.find_by(address: params[:spot][:address])
      else
      #新しいspotを作成
        spot = Spot.new(spot_params)
        spot.save
       #wineを更新をする(カラム名：↑で作成されたspotのid)
      end
      @wine.update(spot_id: spot.id)
    end
    redirect_to edit_admin_wine_path(params[:spot][:wine_id])
  end

  def destroy
    @spot = Spot.find(params[:id])
    @spot.destroy
    redirect_to admin_spots_spots_list_path
  end


  private

  def spot_params
    params.require(:spot).permit(:spot_name, :address, :telephone_number, :lat, :lng)
  end

end
