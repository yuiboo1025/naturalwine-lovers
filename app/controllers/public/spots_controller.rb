class Public::SpotsController < ApplicationController
  before_action :authenticate_member!, except: [:index, :show]

  def new
    @spot = Spot.new
  end

  def create
    if Spot.exists?(address: params[:spot][:address])
      spot = Spot.find_by(address: params[:spot][:address])
    else
     spot = Spot.new(spot_params)
      spot.save
    end
    redirect_to new_wine_path(spot_id: spot.id)
  end

  def index
    #退会しているメンバーの投稿情報は表示させない
    member = Member.where(is_deleted: false)
    #spotテーブルとwineテーブルを結合して、wineの情報があるものだけ取ってきている
    #結合すると、wineの個数分spotのレコードができてしまうので、uniqで重複削除をしている
    @spots = Spot.joins(:wines).where(wines: {member_id: member}).all.uniq
  end

  def show
    @spot = Spot.find(params[:id])
    @wines = @spot.wines.order(id: "DESC")
    @genres = Genre.all
  end

  def edit
    #wine投稿済のデータからは_wine_formからwine_idが送られてきている。
    #投稿する前に店情報を編集したいとき(まだwine_idを持っていない時)、編集画面ではなく初めの場所投稿画面に遷移するようにする
    if params[:wine_id].blank?
      redirect_to new_spot_path
    else
      @spot = Spot.find(params[:id])
    end
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
    redirect_to edit_wine_path(params[:spot][:wine_id])
  end

  private

  def spot_params
    params.require(:spot).permit(:spot_name, :address, :telephone_number, :lat, :lng)
  end

end
