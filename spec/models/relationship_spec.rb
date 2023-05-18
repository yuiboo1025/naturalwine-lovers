require 'rails_helper'

RSpec.describe Relationship, type: :model do

  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'Memberモデル(followed)との関係' do
      let(:target) { :followed }

      it 'Memberモデル(followed)との関連付けはbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end

      it '結合するモデルのクラスはMember' do
        expect(association.class_name).to eq 'Member'
      end
    end

    context 'Userモデル(follower)との関係' do
      let(:target) { :follower }

      it 'Memberモデル(follower)との関連付けはbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end

      it '結合するモデルのクラスはMember' do
        expect(association.class_name).to eq 'Member'
      end
    end
  end

end