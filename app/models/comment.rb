class Comment < ApplicationRecord
  belongs_to :member
  belongs_to :wine
  
  validates :comment, presence: true
end
