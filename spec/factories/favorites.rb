FactoryBot.define do
  factory :favorite do
    association :plan
    association :user
  end
end