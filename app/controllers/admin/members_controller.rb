class Admin::MembersController < ApplicationController
  def index
    @members = Member.all
    if params[:q] && params[:q].reject { |key,value| value.blank? }.present?
      @q = @members.ransack(search_params, activated_true: true)
      @title = "検索結果"
    else
      @q = @members.ransack(activated_true: true)
      @title = "全てのユーザー"
    end
      @members = @q.result.page(params[:page]).per(6)
  end

  def followings
    @member = Member.find(params[:id])
    @members = @member.followings
    if params[:q] && params[:q].reject { |key,value| value.blank? }.present?
      @q = @members.ransack(search_params, activated_true: true)
      @title = "検索結果(フォローしているユーザー)"
    else
      @q = @members.ransack(activated_true: true)
      @title = "フォローしているユーザー"
    end
      @members = @q.result.page(params[:page]).per(6)
  end

  def followers
    @member = Member.find(params[:id])
    @members = @member.followers
    if params[:q] && params[:q].reject { |key,value| value.blank? }.present?
      @q = @members.ransack(search_params, activated_true: true)
      @title = "検索結果(フォロワー)"
    else
      @q = @members.ransack(activated_true: true)
      @title = "フォロワー"
    end
      @members = @q.result.page(params[:page]).per(6)
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      flash[:notice] = "会員情報の更新が完了しました。"
      redirect_to admin_member_path(@member.id)
    else
      flash[:error] = "情報が足りていないか、または情報が正しくありません。"
      render :edit
    end
  end
  
  #ブックマークした投稿一覧
  def bookmarks
    @member = Member.find(params[:id])
    #ユーザーidが、このユーザーの、ブックマークのレコードを全て取得。そのwine_idも一緒に持ってくる
    #bookmarksには、あるユーザーがブックマークした投稿のidが入っている
    bookmarks= Bookmark.where(member_id: @member.id).pluck(:wine_id)
    @bookmark_wines = Wine.find(bookmarks)
    @genres = Genre.all
  end
  
  #フォローした人の投稿一覧
  def followings_wine
    @member = Member.find(params[:id])
    @members = @member.followings.where(is_deleted: false)
    @followings_wines = Wine.where(member_id: @members).order(id: "DESC")
    @genres = Genre.all
  end
  

  private

  def member_params
    params.require(:member).permit(:name, :email, :profile_image, :favorite_genre, :prefecture, :introduction, :is_deleted)
  end

  def search_params
    params.require(:q).permit(:name_cont)
  end


end
