class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name,  presence: true, uniqueness: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
  #  備考：パスワードデフォルトで６文字以上を要求している
  #  備考：メールアドレスはデフォルトで一意であることを要求している

  has_many :wines, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  # A：自分がフォローしているユーザーとの関連(与フォロー)
  # フォローする場合の中間テーブルを「relationships」と名付ける。外部キーは「follower_id」
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed

  # B：自分がフォローされるユーザーとの関連(被フォロー)
  # フォローする場合の中間テーブルを「reverse_of_relationships」と名付ける。外部キーは「followed_id」
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_one_attached :profile_image

  # フォローをした時の処理
  def follow(member)
    relationships.create(followed_id: member.id)
  end
  # フォローを外す時の処理
  def unfollow(member)
    relationships.find_by(followed_id: member.id).destroy
  end
  # フォローしているか判定
  def following?(member)
    followings.include?(member)
  end

  # プロフィール写真を表示するためのメソッドを作成
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    profile_image.variant(resize_to_fill: [width, height]).processed
  end

  # ログイン時に退会済みのユーザーが同じアカウントでログイン出来ないよう制約
  # is_deletedがfalseならtrueを返すようにしている
  def active_for_authentication?
    super && (is_deleted == false)
  end

  # ransack使用する際、出てきたエラーに下記文を記載するよう指示文があったので記述。
  def self.ransackable_attributes(auth_object = nil)
    ["email", "encrypted_password", "favorite_genre", "id", "introduction", "is_deleted", "name", "prefecture", "activated_true"]
  end

  # ゲストログイン用。app/controllers/members/sessions_controller.rbで記述したMember.guestのguestメソッドを定義
  def self.guest
    find_or_create_by!(name: "guestuser", email: "guest@example.com") do |member|
      member.password = SecureRandom.urlsafe_base64
      member.name = "guestuser"
      member.prefecture = 13
      member.favorite_genre = 2
      member.introduction = "ゲストユーザーです。"
    end
  end

  enum favorite_genre: {
    All: 0,
     Sparkling: 1, White: 2, Red: 3, Rose: 4, Orange: 5, Others: 6
   }

  enum prefecture: {
     "---": 0,
     北海道: 1, 青森県: 2, 岩手県: 3, 宮城県: 4, 秋田県: 5, 山形県: 6, 福島県: 7,
     茨城県: 8, 栃木県: 9, 群馬県: 10, 埼玉県: 11, 千葉県: 12, 東京都: 13, 神奈川県: 14,
     新潟県: 15, 富山県: 16, 石川県: 17, 福井県: 18, 山梨県: 19, 長野県: 20,
     岐阜県: 21, 静岡県: 22, 愛知県: 23, 三重県: 24,
     滋賀県: 25, 京都府: 26, 大阪府: 27, 兵庫県: 28, 奈良県: 29, 和歌山県: 30,
     鳥取県: 31, 島根県: 32, 岡山県: 33, 広島県: 34, 山口県: 35,
     徳島県: 36, 香川県: 37, 愛媛県: 38, 高知県: 39,
     福岡県: 40, 佐賀県: 41, 長崎県: 42, 熊本県: 43, 大分県: 44, 宮崎県: 45, 鹿児島県: 46,
     沖縄県: 47
   }
end
