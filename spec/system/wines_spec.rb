require 'rails_helper'

RSpec.describe "Wines", type: :system do
    before do
      @member = FactoryBot.create(:member)
      @genre = FactoryBot.create(:genre)
      @spot = FactoryBot.create(:spot)
      @wine = FactoryBot.create(:wine, genre_id: @genre.id, member_id: @member.id, spot_id: @spot.id)
    end

    describe 'wine投稿画面のテスト' do
      it 'wineの情報入力' do
        sign_in @member
         # wine投稿ページに遷移する
        visit new_wine_path(spot_id: @spot.id)
        #画像を選択
        attach_file 'wine[wine_image]', "#{Rails.root}/spec/fixtures/sakura_1.jpg", match: :first
        #ワインジャンルを選ぶ
        find("#wine_genre_id", match: :first).find("option[value='1']").select_option
        #wineが作成される
        expect{click_on '→　投稿する', match: :first}.to change { Wine.count }.by(1)
      end
    end

    describe '詳細画面のテスト' do
      before do
        sign_in @member
        visit wine_path(@wine.id)
      end
	    context '表示の確認' do
        it 'wineの情報が画面に表示されていること' do
          #sign_in @member
          #visit wine_path(@wine.id)
	        expect(page).to have_content @wine.wine_name
	        expect(page).to have_content @wine.production_country
	        expect(page).to have_content @wine.production_year
	        expect(page).to have_content @wine.impression
	      end
	      it 'Editリンクが表示される' do
	        expect(page).to have_content('Edit')
				end
	    end
	  end
end
