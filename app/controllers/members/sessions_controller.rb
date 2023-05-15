class Members::SessionsController < Devise::SessionsController
  def guest_sign_in
    member = Member.guest
    sign_in member
    redirect_to wines_myindex_path(member), notice: "guestuserでログインしました。"
  end
end
