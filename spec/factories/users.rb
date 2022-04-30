FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'Abc123' }
    password_confirmation { 'Abc123' }
  end
end