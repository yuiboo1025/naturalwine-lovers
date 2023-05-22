require 'rails_helper'

RSpec.describe "Spots", type: :system do
    before do
      @member = FactoryBot.create(:member)
      @spot = FactoryBot.create(:spot)
    end
    
    describe 'Spot作成機能' do
      context '新たなspotの作成' do
        it 'spotを作成することができる' do
          # ログインする
          sign_in(@member)
          # Mypageに遷移する
          visit wines_myindex_path(@member)
          # 右下の投稿ボタンをクリックする
          find('.plus-button').click
          #店情報入力画面が表示される
          visit new_spot_path
          # 情報を入力する
          fill_in 'spot[address]',  with: '住所'
          #→ 店情報の入力完了ボタンをクリックすると、Spotが新たに作られている
          expect{click_on '→　店情報の入力完了'}.to change { Spot.count }.by(1)
        end
      end
  
      context '既に作成されたSpot情報を入力' do
        it 'Spotは新たに作成されない' do
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
          #→ 店情報の入力完了ボタンをクリックしても、Spotは作られない
          expect{click_on '→　店情報の入力完了'}.to change { Spot.count }.by(0)
        end
      end
    end
    
    describe 'Spot削除機能' do
      context 'Spotの削除' do
        it 'Spotが削除される' do
          # Spotリスト一覧ページへ移動する
          visit admin_spots_spots_list_path
          # Deleteボタンを押すとジャンルのカウントが1下がることを確認する
          expect{click_on 'Delete'}.to change { Spot.count }.by(-1)
        end
      end
    end
    
    describe 'Spot表示確認' do
      context 'Spot一覧画面' do
        it 'mapが表示される' do
          # Spot一覧ページへ移動する
          visit spots_path
          # mapがあることを確認する
          expect(page).to have_css('#map')
        end
      end
      
      context 'Spot詳細画面' do
        it 'mapが表示される' do
          # Spot詳細ページへ移動する
          visit spot_path(@spot)
          # spot情報があることを確認する
          expect(page).to have_content @spot.spot_name
	        expect(page).to have_content @spot.address
	        expect(page).to have_css('#map')
        end
      end
    end
    
end