FactoryBot.define do
  factory :content do
    order { "1" }
    hour { "17" }
    minute { "00" }
    place { Faker::Lorem.sentence }
    explanation { Faker::Lorem.sentence }
    name { Faker::Lorem.sentence }
    address { Faker::Address.name}
    telephonenumber { Faker::PhoneNumber.cell_phone }
    access { Faker::Lorem.sentence }
    businesshours { Faker::Lorem.sentence }
    reservation { "完全予約制" }
    price { Faker::Lorem.sentence }
    stay_time { Faker::Lorem.sentence }
    rate { 5 }
    association :plan
  end
end