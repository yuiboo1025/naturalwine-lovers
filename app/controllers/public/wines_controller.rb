class Public::WinesController < ApplicationController
  before_action :authenticate_member!, except: [:index]
  
  def index
    #アソシエーション先での検索方法。(wineからmemberを指定して取り出したいときの書き方)
    #@wines = Wine.includes(:member).where(member: { is_deleted: false }).page(params[:page]).per(8)
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

  def new
    @wine = Wine.new
    @spot = Spot.find(params[:spot_id])
  end

  def edit
    @wine = Wine.find(params[:id])
    @spot = @wine.spot
  end

  def create
    @wine = current_member.wines.new(wine_params)
    if @wine.save
      flash[:notice] = "ナチュール投稿が成功しました。"
      redirect_to wine_path(@wine.id)
    else
      flash[:error] = "情報が足りません。必須項目が入力されているか確認してください。"
      redirect_to request.referer
    end
  end

  def update
    @wine = Wine.find(params[:id])
    if @wine.update(wine_params)
      flash[:notice] = "ナチュール投稿の更新が完了しました。"
      redirect_to wine_path(@wine.id)
    else
      flash[:error] = "情報が足りません。必須項目が入力されているか確認してください"
      render :edit
    end
  end

  def destroy
    wine = Wine.find(params[:id])
    if wine.destroy
      flash[:notice] = "削除が完了しました。"
      redirect_to wines_myindex_path(current_member)
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
