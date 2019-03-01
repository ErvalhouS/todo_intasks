FactoryBot.define do
  factory :category do
    title { "MyString" }
    user { nil }
    after :create do |category|
      create_list :task, 3, category: category   # has_many
    end
  end
end
