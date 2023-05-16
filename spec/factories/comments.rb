FactoryBot.define do
  factory :comment do
    association :member
    association :wine
    comment { Faker::Lorem.characters(number: 10) }
  end
end