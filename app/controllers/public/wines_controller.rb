class Public::WinesController < ApplicationController
  #ログインしていないと、投稿一覧画面以外は見れない
  before_action :authenticate_member!, except: [:index]

  def index
    # アソシエーション先での検索方法。(wineからmemberを指定して取り出したいときの書き方)
    @wines = Wine.includes(:member).where(member: { is_deleted: false }).order(id: "DESC")
    @genres = Genre.all
    # 左外部結合（LEFT OUTER JOIN）は、1つ目のテーブルのカラムを優先して2つ目のテーブルを結合する、その際、2つのテーブルのどちらかにしか存在しないデータも含める
    # includesとwhereを同時に使用すると、SQLの発行回数を少なく抑えつつ、条件をつけられる。
  end

  def myindex
    @member = Member.find(params[:id])
    @wines = @member.wines.all.order(id: "DESC")
    @genres = Genre.all
  end

  def again_index
    @member = Member.find(params[:id])
    @wines = @member.wines.all
    @again_wines = @wines.where(is_again: true).order(id: "DESC")
    @genres = Genre.all
  end
  
  def mymap
    @member = Member.find(params[:id])
    # spotテーブルとwineテーブルを結合して、wineの情報があるものだけ取ってきている
    # 結合すると、wineの個数分spotのレコードができてしまうので、uniqで重複削除をしている
    @spots = Spot.joins(:wines).where(wines: {member_id: @member}).all.uniq
    # joinsはテーブル同士を内部結合して検索するためのメソッド
    # joinsとwhere句を組み合わせることによって、内部結合した後に条件を指定してデータ取り出せる
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
    # 違う人の投稿編集画面へはurlからでも遷移できないよう制限
    unless @wine.member.id == current_member.id
      redirect_to wine_path(@wine)
    end
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
    # 違う人の投稿は更新できないように制限
    unless @wine.member.id == current_member.id
      redirect_to wine_path(@wine)
    end
    
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
