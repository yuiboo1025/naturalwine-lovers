require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @member = FactoryBot.build(:member)
  end
  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('Sign-Up')
      # 新規登録ページへ移動する
      visit new_member_registration_path
      # ユーザー情報を入力する
      fill_in 'member[name]', with: @member.name
      fill_in 'member[email]', with: @member.email
      fill_in 'member[password]', with: @member.password
      fill_in 'member[password_confirmation]', with: @member.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{find('input[name="commit"]').click}.to change { Member.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq(root_path)
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
      fill_in 'member[name]', with: ''
      fill_in 'member[email]', with: ''
      fill_in 'member[password]', with: ''
      fill_in 'member[password_confirmation]', with: ''
      # サインアップボタンを押してもユーザーモデルのカウントが上がらないことを確認する
      expect{find('input[name="commit"]').click}.to change { Member.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq(new_member_registration_path)
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @member = FactoryBot.build(:member)
  end
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
      find('input[name="commit"]').click

      # マイページへ遷移することを確認する
      expect(current_path).to eq{wines_myindex_path(@member)}
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
      find('input[name="commit"]').click

      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_member_session_path)
    end
  end
end