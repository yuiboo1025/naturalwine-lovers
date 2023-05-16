FactoryBot.define do
  factory :member do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    favorite_genre { 1 }
    prefecture { 1 }
    introduction { Faker::Lorem.characters(number: 20) }
    is_deleted { false }
  end
end