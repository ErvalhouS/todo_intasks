FactoryBot.define do
  factory :task do
    title { "#{Faker::Hacker.verb} #{Faker::Hacker.noun}" }
    description { Faker::Hacker.say_something_smart }
    due_at { Time.now + rand(365).days }
    user
  end
end
