FactoryBot.define do
  factory :content do
    order { "1" }
    hour { "17" }
    minute { "00" }
    place { Faker::Lorem.sentence }
    explanation { Faker::Lorem.sentence }
    name { Faker::Lorem.sentence }
    address { "〒279-0031 千葉県浦安市舞浜1-1" }
    telephonenumber { Faker::PhoneNumber.cell_phone }
    access { Faker::Lorem.sentence }
    businesshours { Faker::Lorem.sentence }
    reservation { "完全予約制" }
    price { Faker::Lorem.sentence }
    stay_time { Faker::Lorem.sentence }
    rate { 5 }
    latitude { 35.632896 }
    longitude { 139.880394 }
    association :plan
  end
end