class Spot < ApplicationRecord
  has_many :wines, dependent: :destroy
end
