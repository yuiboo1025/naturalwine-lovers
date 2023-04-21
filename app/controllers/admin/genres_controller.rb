class Admin::GenresController < ApplicationController
  def index
    @genre=Genre.new
    @genres=Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "ジャンルが追加されました。"
      redirect_to request.referer
    else
      flash[:error] = "※情報が足りません"
      redirect_to request.referer
    end
  end

  def edit
    @genre=Genre.find(params[:id])
  end

  def update
    @genre=Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "ジャンルの更新が完了しました。"
      redirect_to admin_genres_path
    else
      flash[:error] = "ジャンル編集が完了できていません。"
      render :edit
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:genre_name)
  end
end
