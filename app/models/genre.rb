class Genre < ApplicationRecord
  has_many :wines, dependent: :destroy
  validates :genre_name, presence: true
end
