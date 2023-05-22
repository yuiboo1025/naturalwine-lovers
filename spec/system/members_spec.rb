require 'rails_helper'

RSpec.describe 'Devise', type: :system do
  before do
    @member = FactoryBot.create(:member)
  end

  describe 'ユーザー新規登録' do
    context 'ユーザー新規登録ができるとき' do
      it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
        # トップページに移動する
        visit root_path
        # トップページにサインアップページへ遷移するボタンがあることを確認する
        expect(page).to have_content('Sign-Up')
        # 新規登録ページへ移動する
        visit new_member_registration_path
        # ユーザー情報を入力する
        fill_in 'member[name]', with: 'test', match: :first
        fill_in 'member[email]', with: 'test@test', match: :first
        fill_in 'member[password]', with: 'testtest', match: :first
        fill_in 'member[password_confirmation]', with: 'testtest', match: :first
        # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
        expect{click_on 'Sign-Up', match: :first}.to change { Member.count }.by(1)
        # mypageへ遷移する
        member = Member.find_by(email: 'test@test')
        expect(current_path).to eq(wines_myindex_path(member))
        # カーソルを合わせるとログアウトボタンが表示されることを確認する
        expect(page).to have_content('ログアウト')
      end
    end

    context 'ユーザー新規登録ができないとき' do
      it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
        # トップページに移動する
        visit root_path
        # トップページにサインアップページへ遷移するボタンがあることを確認する
        expect(page).to have_content('Sign-Up')
        # 新規登録ページへ移動する
        visit new_member_registration_path
        # ユーザー情報を入力する
        fill_in 'member[name]', with: '', match: :first
        fill_in 'member[email]', with: '', match: :first
        fill_in 'member[password]', with: '', match: :first
        fill_in 'member[password_confirmation]', with: '', match: :first
        # サインアップボタンを押してもユーザーモデルのカウントが上がらないことを確認する
        expect{click_on 'Sign-Up', match: :first}.to change { Member.count }.by(0)
        # 新規登録ページへ戻されることを確認する
        expect(current_path).to eq(members_path)
      end
    end
  end

  describe 'ログイン' do
    context 'ログインができるとき' do
      it '保存されているユーザーの情報と合致すればログインができる' do
        # トップページに移動する
        visit root_path
        # トップページにログインページへ遷移するボタンがあることを確認する
        expect(page).to have_content('Log-In')
        # ログインページへ遷移する
        visit new_member_session_path
        # 正しいユーザー情報を入力する
        fill_in 'member[email]', with: @member.email
        fill_in 'member[password]', with: @member.password
        # ログインボタンを押す
        click_on 'Log-In'
        # マイページへ遷移することを確認する
        expect(current_path).to eq wines_myindex_path(@member)
      end
    end
    context 'ログインができないとき' do
      it '保存されているユーザーの情報と合致しないとログインができない' do
        # トップページに移動する
        visit root_path
        # トップページにログインページへ遷移するボタンがあることを確認する
        expect(page).to have_content('Log-In')
        # ログインページへ遷移する
        visit new_member_session_path
        # ユーザー情報を入力する
        fill_in 'member[email]',  with: ''
        fill_in 'member[password]', with: ''
        # ログインボタンを押す
        click_on 'Log-In'
        # ログインページへ戻されることを確認する
        expect(current_path).to eq new_member_session_path
      end
    end
  end
end

RSpec.describe 'Member', type: :system do
  before do
    @member = FactoryBot.create(:member)
  end
  
  describe '一覧画面のテスト' do
    context '表示の確認' do
      it 'メンバー情報が表示されている' do
        sign_in @member
        visit members_path
	      expect(page).to have_selector("img[src$='no_image.jpg']")
	      expect(page).to have_content @member.name
	      expect(page).to have_content @member.prefecture
	      expect(page).to have_content @member.favorite_genre
      end
    end
  end
end