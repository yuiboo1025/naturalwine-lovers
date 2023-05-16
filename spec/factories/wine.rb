FactoryBot.define do
  factory :wine do
    wine_name { Faker::Lorem.characters(number: 10) }
    production_country { Faker::Lorem.characters(number: 5) }
    production_country { Faker::Lorem.characters(number: 5) }
    production_year { Faker::Lorem.characters(number: 5) }
    rate { 4.0 }
    impression { Faker::Lorem.characters(number: 30) }
    is_again { true }
  end
end