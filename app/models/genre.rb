class Genre < ApplicationRecord
  has_many :wines,dependent: :destroy
end
