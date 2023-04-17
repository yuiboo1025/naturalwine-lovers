class Public::MembersController < ApplicationController
  before_action :authenticate_member!, except: [:index] 
  #ゲストユーザーにはユーザー情報編集できないようにするため
  before_action :ensure_guest_member, only: [:edit]
  
  def index
    #params[:q]で、欲しいデータが送られてきているかチェック
    #送られてきている、かつ、データが存在しているか確認している。
    #左側のparams[:q]の記述がないと、そもそもデータが送られてきていない場合、エラーが出てきてしまう。
    @exist_members = Member.where(is_deleted: false)
    if params[:q] && params[:q].reject { |key,value| value.blank? }.present?
      @q = @exist_members.ransack(search_params, activated_true: true)
      @title = "検索結果"
    else
      @q = @exist_members.ransack(activated_true: true)
      @title = "全てのユーザー"
    end
      @members = @q.result.all
      #@members = @q.result.paginate(page: params[:page])
  end
  
  def followings
    @member = Member.find(params[:id])
    @members = @member.followings.where(is_deleted: false)
    if params[:q] && params[:q].reject { |key,value| value.blank? }.present?
      @q = @members.ransack(search_params, activated_true: true)
      @title = "検索結果(フォローしているユーザー)"
    else
      @q = @members.ransack(activated_true: true)
      @title = "フォローしているユーザー"
    end
      @members = @q.result.all
      #@members = @q.result.paginate(page: params[:page])
  end

  def followers
    @member = Member.find(params[:id])
    @members = @member.followers.where(is_deleted: false)
    if params[:q] && params[:q].reject { |key,value| value.blank? }.present?
      @q = @members.ransack(search_params, activated_true: true)
      @title = "検索結果(フォロワー)"
    else
      @q = @members.ransack(activated_true: true)
      @title = "フォロワー"
    end
      @members = @q.result.all
      #@members = @q.result.paginate(page: params[:page])
  end
  
  def show
    @member = current_member
  end

  def edit
    @member = current_member
  end
  
  def update
    @member = current_member
    if @member.update(member_params)
      redirect_to member_path(@member), notice: '会員情報の更新が完了しました。'
    else
      render :edit
    end
  end
  
  def bookmarks
    @member = Member.find(params[:id])
    #ユーザーidが、このユーザーの、ブックマークのレコードを全て取得。そのwine_idも一緒に持ってくる
    #bookmarksには、あるユーザーがブックマークした投稿のidが入っている
    bookmarks= Bookmark.where(member_id: @member.id).pluck(:wine_id)
    @bookmark_wines = Wine.find(bookmarks)
    @genres = Genre.all
  end

  def unsubscribe
  end

  def withdraw
    @member = current_member
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @member.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private
  
  #ユーザーの編集画面へのURLを直接入力された場合にはメッセージを表示してユーザー詳細画面へリダイレクトさせる。
  #before_actionでeditアクション実行前に処理を行う。
  def ensure_guest_member
    @member = Member.find(params[:id])
    if @member.name == "guestmember"
      redirect_to member_path(current_member) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end 

  def set_current_member
    @member = current_member
  end

  def member_params
    params.require(:member).permit(:name, :profile_image, :favorite_genre, :prefecture, :introduction)
  end
  
  def search_params
    params.require(:q).permit(:name_cont)
  end
  
end
