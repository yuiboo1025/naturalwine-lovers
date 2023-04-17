class Admin::MembersController < ApplicationController
  def index
    #@members = Member.all
    @members = Member.all
    if params[:q] && params[:q].reject { |key,value| value.blank? }.present?
      @q = @members.ransack(search_params, activated_true: true)
      @title = "検索結果"
    else
      @q = @members.ransack(activated_true: true)
      @title = "全てのユーザー"
    end
      @members = @q.result.all
      #@members = @q.result.paginate(page: params[:page])
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
    params.require(:member).permit(:name, :email, :profile_image, :favorite_genre, :prefecture, :introduction, :is_deleted)
  end

  def search_params
    params.require(:q).permit(:name_cont)
  end


end
