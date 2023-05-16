require 'rails_helper'

RSpec.describe Spot, type: :model do
  describe 'モデルのテスト' do
    it "有効なspotの場合は保存されるか" do
      expect(build(:spot)).to be_valid
    end
  end
end