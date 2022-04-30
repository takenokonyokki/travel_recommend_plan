FactoryBot.define do
  factory :plan do
    title { Faker::Lorem.sentence } 
    travel { 0 }
  end
end