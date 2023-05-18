require 'rails_helper'

RSpec.describe Spot, type: :model do

  before do
    @member = FactoryBot.create(:member)
    @genre = FactoryBot.create(:genre)
    @spot = FactoryBot.create(:spot)
  end

  describe 'モデルのテスト' do
    it "有効なspotの場合は保存されるか" do
      expect(@spot).to be_valid
    end
  end

  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'Wineモデルとの関係' do
      let(:target) { :wines }

      it 'Wineとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :has_many
      end

      it "Spotが削除されたらWineも削除されること" do
        FactoryBot.create(:wine, genre_id: 1, member_id: @member.id, spot_id: @spot.id)
        expect{ @spot.destroy }.to change{ Wine.count }.by(-1)
      end
    end
  end

end