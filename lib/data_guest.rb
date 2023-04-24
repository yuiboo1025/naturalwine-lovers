class Guestuser::DataGuest

  # guestuserの投稿を削除
  def self.data_reset
    member = Member.find_by(email: "guest@example.com")
    member.wines.destroy_all
    member.comments.destroy_all
    member.favorites.destroy_all
    member.bookmarks.destroy_all
  end
end