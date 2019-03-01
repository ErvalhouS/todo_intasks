FactoryBot.define do
  factory :user do
    name { Faker::DcComics.name }
    email { Faker::Internet.email }
    password { Faker::Internet.email }
    password_confirmation { password }
    confirmed_at { Time.now }
    factory :admin do
      role { 'admin' }
    end
  end
end
