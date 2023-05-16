FactoryBot.define do
  factory :bookmark do
    association :member
    association :wine
  end
end