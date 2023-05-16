require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'モデルのテスト' do
    it "有効なcommentの場合は保存されるか" do
      expect(build(:comment)).to be_valid
    end
  end
end