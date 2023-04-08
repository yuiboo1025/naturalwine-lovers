class Public::WinesController < ApplicationController
  before_action :authenticate_member!

  def index
    @wines = Wine.all
    @genres = Genre.all
    if params[:genre_id]
		  @genre = Genre.find(params[:genre_id])
		  @wines = @genre.wines
    else
      @wines = Wine.all
    end
  end

  def myindex
    @member = Member.find(params[:id])
    @wines = @member.wines.all
    @genres = Genre.all
    if params[:genre_id]
		  @genre = Genre.find(params[:genre_id])
		  @wines = @genre.wines
    else
      @wines = @member.wines.all
    end
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
    @wine.save
    redirect_to wine_path(@wine.id)

    #if @wine.save
     # redirect_to wine_path(@wine.id)
   # else
    #  @message = "※情報が足りません"
    #  render :new
   # end
  end

  def update
    @wine = Wine.find(params[:id])
    if @wine.update(wine_params)
      redirect_to wine_path(@wine.id)
    else
      @message = "※情報が足りません"
      render :edit
    end
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
    params.require(:member).permit(:name, :profile_image, :favorite_genre, :prefecture, :introduction)
  end
  
  def spot_params
    params.require(:spot).permit(:spot_name, :address, :telephone_number, :lat, :lng)
  end

end
