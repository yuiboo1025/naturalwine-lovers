class Wine < ApplicationRecord
  belongs_to :member
  belongs_to :genre
  belongs_to :spot
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  
  has_one_attached :wine_image
  
    #投稿写真を表示するためのメソッドを作成。画像サイズの変更。
  def get_wine_image(width,height)
    wine_image.variant(resize_to_limit:[width, height]).processed
  end
  
  #引数で渡されたメンバーidがFavoritesテーブル内に存在（exists?） していればtrue、存在していなければfalseを返す
  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end
  
  def bookmarked_by?(member)
    bookmarks.exists?(member_id: member.id)
  end
end
