require 'rails_helper'

RSpec.describe Wine, type: :model do
  before do
    @member = FactoryBot.create(:member)
    @genre = FactoryBot.create(:genre)
    @spot = FactoryBot.create(:spot)
  end

  describe 'モデルのテスト' do
    it "有効なwineの場合は保存されるか" do
      # FactoryBotで作ったデータが有効であるか確認しています
      expect(FactoryBot.build(:wine, member_id: @member.id, genre_id: @genre.id, spot_id: @spot.id)).to be_valid
    end

    context "空白のバリデーションチェック" do
      it "wine_imageが空白の場合保存されないか" do
        # wineにwine_imageカラムを空で保存したものを代入
        wine = build(:wine, wine_image: nil)
        # wine_imageカラムでエラーが出て、エラーメッセージに"を入力してください"が含まれているか？
        expect(wine.valid?).to eq false
      end
    end

    context "空白のバリデーションチェック" do
      it "genreが空白の場合にエラーメッセージが返ってくるか" do
        # genreにwine_imageカラムを空で保存したものを代入
        genre = build(:genre, genre_name: nil)
        # バリデーションチェックを行う
        genre.valid?
        # wine_imageカラムでエラーが出て、エラーメッセージに"を入力してください"が含まれているか？
        expect(genre.errors[:genre_name]).to include("を入力してください")
      end
    end
  end

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