require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "Memberモデルとの関係" do
      let(:target) { :member }

      it "Memberとの関連付けはbelongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context "Wineモデルとの関係" do
      let(:target) { :wine }

      it "Wineとの関連付けはbelongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end