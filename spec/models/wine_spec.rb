require 'rails_helper'

RSpec.describe Wine, type: :model do
  describe 'モデルのテスト' do
    it "有効なwineの場合は保存されるか" do
      expect(build(:wine)).to be_valid
    end
  end
end