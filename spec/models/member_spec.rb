require 'rails_helper'

RSpec.describe Member, type: :model do

  describe 'モデルのテスト' do
    it "有効なmemberの場合は保存されるか" do
      # FactoryBotで作ったデータが有効であるか確認しています
      expect(build(:member)).to be_valid
    end

    context "空白のバリデーションチェック" do
      it "nameが空白の場合にエラーメッセージが返ってくるか" do
        # memberにnameカラムを空で保存したものを代入
        member = build(:member, name: nil)
        # バリデーションチェックを行う
        member.valid?
        # nameカラムでエラーが出て、エラーメッセージに"を入力してください"が含まれているか？
        expect(member.errors[:name]).to include("を入力してください")
      end
      it "emailが空白の場合にエラーメッセージが返ってくるか" do
        # emailのバリデーションチェック
        member = build(:member, email: nil)
        member.valid?
        expect(member.errors[:email]).to include("を入力してください")
      end
      it "passwordが空白の場合にエラーメッセージが返ってくるか" do
        # passwordのバリデーションチェック
        member = build(:member, password: nil)
        member.valid?
        expect(member.errors[:password]).to include("を入力してください")
      end
    end

    context "一意性制約の確認" do
      # itの前に@memberにbuild(:member)を代入
      before do
        @member = build(:member)
      end

      it "同じnameの場合エラーメッセージが返ってくるか" do
        # @memberを保存
        @member.save
        # another_memberにbuild(:member)を保存
        another_member = build(:member)
        # another_memberのnameカラムに@memberと同じnameを代入
        another_member.name = @member.name
        # @memberと同じnameになるので、バリデーションチェックに引っかかる
        another_member.valid?
        expect(another_member.errors[:name]).to include("はすでに存在します")
      end
      it "同じemailの場合エラーメッセージが返ってくるか" do
        # emailバージョン
        @member.save
        another_member = build(:member)
        another_member.email = @member.email
        another_member.valid?
        expect(another_member.errors[:email]).to include("はすでに存在します")
      end
    end

    context "その他passwardカラムについて" do
      it "passwordの文字数が6文字未満の場合エラーメッセージが返ってくるか" do
        # nameカラムに１文字を入れる
        member = build(:member, password: Faker::Lorem.characters(number: 1))
        member.valid?
        expect(member.errors[:password]).to include("は6文字以上で入力してください")
      end
      it 'パスワードが不一致' do
        member = build(:member, password: "password1", password_confirmation: "password2")
        member.valid?
        expect(member.errors[:password_confirmation]).to include("とPasswordの入力が一致しません")
      end
    end

  end

end
