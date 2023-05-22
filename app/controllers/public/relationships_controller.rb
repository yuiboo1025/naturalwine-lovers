class Public::RelationshipsController < ApplicationController
  def create
    @member = Member.find(params[:member_id])
    #memberモデルで作成したメソッド follow(member) を使用
    current_member.follow(@member)
  end

  def destroy
    @member = Member.find(params[:member_id])
    #memberモデルで作成したメソッド unfollow(member) を使用
    current_member.unfollow(@member)
  end
end
