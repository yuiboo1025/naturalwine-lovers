class Public::RelationshipsController < ApplicationController
  
  def create
    @member = Member.find(params[:member_id])
    current_member.follow(@member)
  end
  
  def destroy
    @member = Member.find(params[:member_id])
    current_member.unfollow(@member)
  end
  
end
