class Public::RelationshipsController < ApplicationController
  
  def create
    member = Member.find(params[:member_id])
    current_member.follow(member)
		redirect_to request.referer
  end
  
  def destroy
    member = Member.find(params[:member_id])
    current_member.unfollow(member)
		redirect_to request.referer
  end
  
  #フォロー一覧
  def followings
    member = Member.find(params[:member_id])
		@members = member.followings
		
  end
  
  #フォロワー一覧
  def followers
    member = Member.find(params[:member_id])
		@members = member.followers
  end
  
end
