FactoryBot.define do
  factory :spot do
    spot_name { Faker::Lorem.characters(number: 10) }
    address { Faker::Lorem.characters(number: 30) }
  end
end