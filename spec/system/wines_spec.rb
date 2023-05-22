require 'rails_helper'

RSpec.describe "Wines", type: :system do
    before do
      @member = FactoryBot.create(:member)
      @genre = FactoryBot.create(:genre)
      @spot = FactoryBot.create(:spot)
      @wine = FactoryBot.create(:wine, genre_id: @genre.id, member_id: @member.id, spot_id: @spot.id)
    end

    describe 'wine投稿画面のテスト' do
      before do
        sign_in @member
        # wine投稿ページに遷移する
        visit new_wine_path(spot_id: @spot.id)
      end
      
      it 'wineの情報入力すると投稿できる' do
        #画像を選択
        attach_file 'wine[wine_image]', "#{Rails.root}/spec/fixtures/sakura_1.jpg", match: :first
        #ワインジャンルを選ぶ
        find("#wine_genre_id", match: :first).find("option[value='1']").select_option
        #wineが作成されない
        expect{click_on '→　投稿する', match: :first}.to change { Wine.count }.by(1)
        expect(page).to have_content 'ナチュール投稿が成功しました。'
      end
      
      it 'wine_imageの情報がないと投稿できない' do
        #画像を選択しない
        #ワインジャンルを選ぶ
        find("#wine_genre_id", match: :first).find("option[value='1']").select_option
        #wineが作成されない
        expect{click_on '→　投稿する', match: :first}.to change { Wine.count }.by(0)
        expect(page).to have_content '情報が足りません。'
      end
      
      it 'genreの情報がないと投稿できない' do
        #画像を選択
        attach_file 'wine[wine_image]', "#{Rails.root}/spec/fixtures/sakura_1.jpg", match: :first
        #ワインジャンルを選ばない
        #wineが作成されない
        expect{click_on '→　投稿する', match: :first}.to change { Wine.count }.by(0)
        expect(page).to have_content '情報が足りません。'
      end
    end


    describe '詳細画面のテスト' do
      before do
        sign_in @member
        visit wine_path(@wine.id)
      end
      
	    context '表示の確認' do
        it 'wineの情報が画面に表示されていること' do
	        expect(page).to have_content @wine.wine_name
	        expect(page).to have_content @wine.production_country
	        expect(page).to have_content @wine.production_year
	        expect(page).to have_content @wine.impression
	        expect(page).to have_selector("img[src$='sakura_1.jpg']")
	      end
	      
	      it 'spotの情報が画面に表示されていること' do
	        expect(page).to have_content @spot.spot_name
	        expect(page).to have_content @spot.address
	        expect(page).to have_css('#map')
	      end
	      
	      it 'spot_nameをクリックすると、spot詳細画面に遷移' do
	        click_on @spot.spot_name, match: :first
	        expect(current_path).to eq(spot_path(@spot))
	      end
	      
	      it 'memberの情報が画面に表示されていること' do
	        expect(page).to have_content @member.name
	        expect(page).to have_selector("img[src$='no_image.jpg']")
	      end
	      
	      it 'メンバーnameをクリックすると、member詳細画面(mypage)に遷移' do
	        click_on @member.name, match: :first
	        expect(current_path).to eq(wines_myindex_path(@member))
	      end
	      
	      it 'Editリンクが表示される' do
	        expect(page).to have_content('Edit')
				end
				
				it 'Editリンクをクリックすると投稿編集画面に遷移する' do
	        click_on 'Edit'
	        expect(current_path).to eq(edit_wine_path(@wine))
				end
				
				it 'Deleteリンクが表示される' do
	        expect(page).to have_content('Delete')
				end
				
				it 'Deleteリンクをクリックすると投稿が削除される' do
	        expect{click_on 'Delete'}.to change { Wine.count }.by(-1)
				end
	    end
	  end
	  
	  
	  describe '一覧画面のテスト' do
      before do
        sign_in @member
        visit wines_path
      end
      
	    context '表示の確認' do
        it '投稿の情報が画面に表示されていること' do
	        expect(page).to have_selector("img[src$='sakura_1.jpg']")
	        expect(page).to have_content @spot.spot_name
	        expect(page).to have_content @member.name
	      end
	      
	      it '投稿写真をクリックすると、投稿詳細画面に遷移' do
	        click_on "wine画像", match: :first
	        expect(current_path).to eq(wine_path(@wine))
	      end
	      
	      it 'spot_nameをクリックすると、spot詳細画面に遷移' do
	        click_on @spot.spot_name, match: :first
	        expect(current_path).to eq(spot_path(@spot))
	      end
	      
	      it 'メンバーnameをクリックすると、member詳細画面(mypage)に遷移' do
	        click_on @member.name, match: :first
	        expect(current_path).to eq(wines_myindex_path(@member))
	      end
	    end
	  end
	  
	  describe 'wine編集画面のテスト' do
      before do
        sign_in @member
        # wine投稿ページに遷移する
        visit edit_wine_path(@wine)
      end
      context '編集機能の確認' do
        it 'wineの情報入力すると編集できる' do
          #画像を選択
          attach_file 'wine[wine_image]', "#{Rails.root}/spec/fixtures/sakura_1.jpg", match: :first
          #ワインジャンルを選ぶ
          find("#wine_genre_id", match: :first).find("option[value='1']").select_option
          #wineが作成されない
          click_on '→　投稿する', match: :first
          expect(page).to have_content 'ナチュール投稿の更新が完了しました。'
        end
      end
    end
    
    describe 'mypage画面のテスト' do
      before do
        sign_in @member
        # wine投稿ページに遷移する
        visit wines_myindex_path(@member)
      end
      context '表示の確認' do
        it 'member情報が表示できている' do
          expect(page).to have_selector("img[src$='no_image.jpg']")
	        expect(page).to have_content @member.name
  	      expect(page).to have_content @member.prefecture
  	      expect(page).to have_content @member.favorite_genre
  	      expect(page).to have_content @member.introduction
        end
        
        it '投稿が表示できている' do
          expect(page).to have_selector("img[src$='sakura_1.jpg']")
	        expect(page).to have_content @member.name
	        expect(page).to have_content @spot.spot_name
        end
        
        it '投稿写真をクリックすると、投稿詳細画面に遷移' do
	        click_on "wine画像", match: :first
	        expect(current_path).to eq(wine_path(@wine))
	      end
	      
	      it 'spot_nameをクリックすると、spot詳細画面に遷移' do
	        click_on @spot.spot_name, match: :first
	        expect(current_path).to eq(spot_path(@spot))
	      end
        
      end
    end
end
