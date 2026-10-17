FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "writer#{n}@example.com" }
    name { Faker::Name.name }
  end
end
