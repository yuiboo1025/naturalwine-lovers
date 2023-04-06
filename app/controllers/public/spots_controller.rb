class Public::SpotsController < ApplicationController
  
  def new
    @spot = Spot.new
  end
  
  def index
    @spots = Spot.all
  end
  
  def show
    @spot = Spot.find(params[:id])
  end
  

  def create
    spot = Spot.new(spot_params)
    spot.save
    redirect_to new_wine_path(spot_id: spot.id)
    
     #if spot.save
       # redirect_to new_wine_path(@spot.id)
     #else
       # redirect_to :action => "index"
     #end
  end
    
  private
  
  def spot_params
    params.require(:spot).permit(:spot_name, :address, :telephone_number, :lat, :lng)
  end
  
end
