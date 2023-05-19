require 'rails_helper'

RSpec.describe 'Comment', type: :system do
  before do
    @member = FactoryBot.create(:member)
    @spot = FactoryBot.create(:spot)
    @genre = FactoryBot.create(:genre)
    @wine = FactoryBot.create(:wine, member_id: @member.id, genre_id: @genre.id, spot_id: @spot.id)
  end

  context 'commentの投稿' do
    it 'commentの投稿ができる' do
      # 投稿詳細ページへ移動する
      visit wine_path(@wine)
      # ユーザー情報を入力する
      fill_in 'comment[comment]', with: '美味しそう'
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{click_on '送信する'}.to change { Comment.count }.by(1)
    end
  end
end