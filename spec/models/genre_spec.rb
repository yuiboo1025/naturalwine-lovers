require 'rails_helper'

RSpec.describe Genre, type: :model do
  describe 'モデルのテスト' do
    it "有効なgenreの場合は保存されるか" do
      expect(build(:genre)).to be_valid
    end

    context "空白のバリデーションチェック" do
      it "genre_nameが空白の場合にエラーメッセージが返ってくるか" do
        # genre_nameにgenre_nameカラムを空で保存したものを代入
        genre_name = build(:genre, genre_name: nil)
        # バリデーションチェックを行う
        genre_name.valid?
        # genre_nameカラムでエラーが出て、フラッシュメッセージに"を入力してください"が含まれているか？
        #expect(page).to have_content '足りません'
        expect(genre_name.errors[:genre_name]).to include("を入力してください")
      end
    end

  end
end