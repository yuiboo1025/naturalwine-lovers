require 'rails_helper'

RSpec.describe "Favorites", type: :system do
    before do
      @member = FactoryBot.create(:member)
      @member_2 = FactoryBot.create(:member)
      @genre = FactoryBot.create(:genre)
      @spot = FactoryBot.create(:spot)
      @wine = FactoryBot.create(:wine, genre_id: @genre.id, member_id: @member.id, spot_id: @spot.id)
      @wine_2 = FactoryBot.create(:wine, genre_id: @genre.id, member_id: @member_2.id, spot_id: @spot.id)
      # 1ブックマーク済にしておく
      @bookmark = FactoryBot.create(:bookmark, member_id: @member.id, wine_id: @wine.id)
    end

    describe '#create,#destroy' do
      it 'ユーザーが他の投稿をブックマーク保存でき、ブックマーク保存を解除できる' do
        # ログインする
        sign_in(@member)
        # Mypageに遷移する
        visit wines_myindex_path(@member)
        # 投稿一覧ボタンをクリックする
        click_on '投稿一覧', match: :first
        #投稿一覧画面へ移動
        visit wines_path(@member)
        #ブックマークの表示
        expect(page).to have_css(".fa-bookmark") 
        expect(page).to have_css(".fas") 
        expect(page).to have_css(".far") 
      end
    end
end