FactoryBot.define do
  factory :content do
    order { Faker::Number.between(from: 1) }
    hour { "9" }
    minute { "00" }
    place { Faker::Lorem.sentence }
    explanation { Faker::Lorem.sentence }
  end
end