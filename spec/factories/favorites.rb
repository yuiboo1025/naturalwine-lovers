FactoryBot.define do
  factory :favorite do
    association :member
    association :wine
  end
end