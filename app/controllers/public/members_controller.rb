class Public::MembersController < ApplicationController
  
  def index
    #params[:q]で、欲しいデータが送られてきているかチェック
    #送られてきている、かつ、データが存在しているか確認している。
    #左側のparams[:q]の記述がないと、そもそもデータが送られてきていない場合、エラーが出てきてしまう。
    if params[:q] && params[:q].reject { |key,value| value.blank? }.present?
      @q = Member.ransack(search_params, activated_true: true)
      @title = "検索結果"
    else
      @q = Member.ransack(activated_true: true)
      @title = "全てのユーザー"
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
      redirect_to mypage_path, notice: '会員情報の更新が完了しました。'
    else
      render :edit
    end
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
