require 'rails_helper'

RSpec.describe Member, type: :model do

  describe 'モデルのテスト' do
    it "有効なmemberの場合は保存されるか" do
      # FactoryBotで作ったデータが有効であるか確認しています
      expect(FactoryBot.build(:member)).to be_valid
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

  describe 'アソシエーションのテスト' do
    let(:association) do
      # context＞it内に下記を記述するのと同じ
      # expect(Member.reflect_on_association(:wines).macro).to eq :has_many
      # expect(Member.reflect_on_association(:followings).class_name).to eq 'User'
      described_class.reflect_on_association(target)
    end

    context 'Wineモデルとの関係' do
      let(:target) { :wines }

      it 'Wineとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :has_many
      end
    end

    context "Commentモデルとの関係" do
      let(:target) { :comments }
      it "Commentとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end

    context "Favoriteモデルとの関係" do
      let(:target) { :favorites }
      it "Favoriteとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end

    context "Bookmarkモデルとの関係" do
      let(:target) { :bookmarks }
      it "Bookmarkとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end

    context 'Relationshipモデル(relationships)との関係' do
      let(:target) { :relationships }

      it 'relationshipsとの関連付けはhas_many' do
        expect(association.macro).to eq :has_many
      end
      it '結合するモデルのクラスはRelationship' do
        expect(association.class_name).to eq 'Relationship'
      end
    end

    context '自分がフォローしているユーザーとの関連' do
      let(:target) { :followings }

      it 'followingsとの関連付けはhas_many' do
        expect(association.macro).to eq :has_many
      end
      it '結合するモデルのクラスはMember' do
        expect(association.class_name).to eq 'Member'
      end
    end

    context 'Relationshipモデル(reverse_relationships)との関係' do
      let(:target) { :reverse_of_relationships }

      it 'reverse_relationshipsとの関連付けはhas_many' do
        expect(association.macro).to eq :has_many
      end
      it '結合するモデルのクラスはRelationship' do
        expect(association.class_name).to eq 'Relationship'
      end
    end

    context '自分がフォローされるユーザーとの関連' do
      let(:target) { :followers }

      it 'followersとの関連付けはhas_many' do
        expect(association.macro).to eq :has_many
      end
      it '結合するモデルのクラスはMember' do
        expect(association.class_name).to eq 'Member'
      end
    end

  end

end
