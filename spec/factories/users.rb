FactoryBot.define do
  factory :user do
    name { Faker::DcComics.name }
    email { Faker::Internet.email }
  end
end
