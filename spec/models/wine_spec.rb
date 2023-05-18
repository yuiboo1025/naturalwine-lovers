require 'rails_helper'

RSpec.describe Wine, type: :model do
  
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

    context "Genreモデルとの関係" do
      let(:target) { :genre }

      it "Genreとの関連付けはbelongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context "Spotモデルとの関係" do
      let(:target) { :spot }

      it "Spotとの関連付けはbelongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context 'Commentモデルとの関係' do
      let(:target) { :comments }

      it 'Commentとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :has_many
      end
    end

    context 'Favoriteモデルとの関係' do
      let(:target) { :favorites }

      it 'Favoriteとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :has_many
      end
    end

    context 'Bookmarkモデルとの関係' do
      let(:target) { :bookmarks }

      it 'Bookmarkとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :has_many
      end
    end
  end
end