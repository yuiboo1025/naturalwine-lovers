require 'rails_helper'

RSpec.describe 'Genre', type: :system do

  before do
    @genre = FactoryBot.create(:genre)
  end

  context 'genreの追加' do
    it 'genreの追加ができる' do
      # ジャンル一覧ページへ移動する
      visit admin_genres_path
      # ユーザー情報を入力する
      fill_in 'genre[genre_name]', with: 'Rose'
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{click_on '新規登録'}.to change { Genre.count }.by(1)
    end
  end

  context 'genreの削除' do
    it 'genreの削除ができる' do
      # ジャンル一覧ページへ移動する
      visit admin_genres_path
      # Deleteボタンを押すとジャンルのカウントが1下がることを確認する
      expect{click_on 'Delete'}.to change { Genre.count }.by(-1)
    end
  end
end