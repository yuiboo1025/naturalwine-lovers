require 'rails_helper'

RSpec.describe "Wines", type: :system do
    before do
      @member = FactoryBot.create(:member)
      @spot = FactoryBot.create(:spot)
      @genre = FactoryBot.create(:genre)
    end

    context 'wine投稿' do
      it 'spotの情報入力' do
        # ログインする
        sign_in(@member)

        # Mypageに遷移する
        visit wines_myindex_path(@member)

        # 右下の投稿ボタンをクリックする
        find('.plus-button').click

        #店情報入力画面が表示される
        visit new_spot_path

        # 情報を入力する
        fill_in 'spot[address]',  with: @spot.address

        #「→ 店情報の入力完了ボタン」をクリックすると、Spotが新たに作られている
        click_on '→　店情報の入力完了'
      end

      it 'wineの情報入力' do
         # wine投稿ページに遷移する
        visit new_wine_path

        #画像を選択
        #attach_file 'wine[wine_image]', "#{Rails.root}/spec/fixtures/sakura_1.jpg"

        #情報を入力する
        #fill_in 'wine[genre_id]',  with: @genre.id
        #find("#wine_genre_id").find("option[value='White']").select_option
        #select(value = 'White', from: "wine[genre_id]")
        #select "White", from: "wine_genre_id"

        #wineが作成される
        expect{click_on '→　投稿する'}.to change { Wine.count }.by(1)
      end
    end
end