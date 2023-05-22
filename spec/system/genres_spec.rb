require 'rails_helper'

RSpec.describe 'Genre', type: :system do

  before do
    @genre = FactoryBot.create(:genre)
  end

  describe 'genreの追加,削除,編集機能' do
    context 'genreの追加機能' do
      it 'ジャンル名を入力したらgenreの追加ができる' do
        # ジャンル一覧ページへ移動する
        visit admin_genres_path
        # ジャンル名を入力する
        fill_in 'genre[genre_name]', with: 'Rose'
        # サインアップボタンを押すとジャンルモデルのカウントが1上がることを確認する
        expect{click_on '新規登録'}.to change { Genre.count }.by(1)
        expect(page).to have_content 'ジャンルが追加されました。'
      end
      
      it 'ジャンル名がっ空欄の場合、genreの追加ができない' do
        # ジャンル一覧ページへ移動する
        visit admin_genres_path
        # ジャンル名を入力しない
        fill_in 'genre[genre_name]', with: ''
        # サインアップボタンを押してもジャンルモデルのカウントは変わらないことを確認する
        expect{click_on '新規登録'}.to change { Genre.count }.by(0)
        expect(page).to have_content '※情報が足りません'
      end
    end
    
    context 'genreの追加機能' do
      it 'genreの削除ができる' do
        # ジャンル一覧ページへ移動する
        visit admin_genres_path
        # Deleteボタンを押すとジャンルのカウントが1下がることを確認する
        expect{click_on 'Delete'}.to change { Genre.count }.by(-1)
        expect(page).to have_content '削除が完了しました。'
      end
    end
    
    context 'genreの編集機能' do
      it 'genreの編集ができる' do
        # ジャンル編集ページへ移動する
        visit edit_admin_genre_path(@genre)
        # ジャンル名を再入力する
        fill_in 'genre[genre_name]', with: 'Orange'
        # サインアップボタンを押すとジャンルモデルのカウントは変わらないことを確認する
        expect{click_on '変更を保存'}.to change { Genre.count }.by(0)
        expect(page).to have_content 'ジャンルの更新が完了しました。'
      end
    end
    
  end
end