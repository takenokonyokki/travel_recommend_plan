FactoryBot.define do
  factory :plan do
    title { "タビレコ" }
    travel { 0 }
    association :user
  end
end