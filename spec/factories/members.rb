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
    
    after(:build) do |member|
      member.profile_image.attach(io: File.open('spec/fixtures/no_image.jpg'), filename: 'no_image.jpg', content_type: 'image/jpg')
    end
  end
end