class Wine < ApplicationRecord
  belongs_to :member
  belongs_to :genre
  
  has_one_attached :wine_image
  
    #投稿写真を表示するためのメソッドを作成
  def get_wine_image(width,height)
    unless wine_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      wine_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    wine_image.variant(resize_to_limit:[width, height]).processed
  end
end
