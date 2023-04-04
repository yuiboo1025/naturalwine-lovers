class Admin::MembersController < ApplicationController
  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    @member.update(member_params)
    redirect_to admin_member_path(@member.id)
  end
  
  private
  
  def member_params
    params.require(:member).permit(:name, :profile_image, :favorite_genre, :prefecture, :introduction)
  end
  
end
