require 'rails_helper'

RSpec.describe "Favorites", type: :system do
    before do
      @member = FactoryBot.create(:member)
      @genre = FactoryBot.create(:genre)
      @spot = FactoryBot.create(:spot)
      @wine = FactoryBot.create(:wine, genre_id: @genre.id, member_id: @member.id, spot_id: @spot.id)
    end

    describe '#create,#destroy' do
      it 'ユーザーが他の投稿をいいね、いいね解除できる' do
        # ログインする
        sign_in(@member)
        
        # Mypageに遷移する
        visit wines_myindex_path(@member)
        
        # 投稿一覧ボタンをクリックする
        click_on '投稿一覧', match: :first

        #投稿一覧画面へ移動
        visit wines_path(@member)

        # いいねをするボタンを押す
        find('.favorite-link').click, match: :first
        #expect(page).to have_selector '#liking-btn'
        expect(@wine.favorites.count).to eq(1)

        # いいねを解除する
        #find('.unfavorite-btn').click
        #expect(@wine.favorites.count).to eq(0)
      end
    end
end