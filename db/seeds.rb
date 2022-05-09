# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create!(
  [
    {name: 'もなか', email: 'monaka@test.com', password: 'Password01', password_confirmation: 'Password01', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")},
    {name: 'ポテゴン', email: 'potegon@test.com', password: 'Password02', password_confirmation: 'Password02', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")},
    {name: 'たけのこニョッキーン', email: 'takenoko@test.com', password: 'Password03', password_confirmation: 'Password03', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")},
    {name: 'チョコ', email: 'choko@test.com', password: 'Password04', password_confirmation: 'Password04', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user4.jpg"), filename:"sample-user4.jpg")},
    {name: 'ぼってぃー', email: 'botthi@test.com', password: 'Password05', password_confirmation: 'Password05', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user5.jpg"), filename:"sample-user5.jpg")}
  ]
)

plans = Plan.create!(
  [
    {title: '沖縄旅行1日目', travel: 46, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-plan1.jpg"), filename:"sample-plan1.jpg"), user_id: users[0].id },
    {title: '沖縄旅行2日目', travel: 46, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-plan2.jpg"), filename:"sample-plan2.jpg"), user_id: users[0].id },
    {title: '沖縄旅行3日目', travel: 46, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-plan3.jpg"), filename:"sample-plan3.jpg"), user_id: users[0].id },
    {title: '沖縄旅行4日目', travel: 46, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-plan4.jpg"), filename:"sample-plan4.jpg"), user_id: users[0].id },
    {title: '沖縄旅行5日目', travel: 46, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-plan5.jpg"), filename:"sample-plan5.jpg"), user_id: users[0].id },
    {title: '明太子を食べに福岡へ', travel: 39, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-plan6.jpg"), filename:"sample-plan6.jpg"), user_id: users[1].id },
    {title: '海鮮といえば築地', travel: 12, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-plan7.jpg"), filename:"sample-plan7.jpg"), user_id: users[2].id },
    {title: '名古屋ぶらり旅', travel: 22, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-plan8.jpg"), filename:"sample-plan8.jpg"), user_id: users[4].id }
  ]
)

contents = Content.create!(
  [
    {order: '1', hour: '11', minute: '20', place: '羽田空港出発', explanation: '第2ターミナルから出発', name: '東京国際空港', address: '〒144-0041 東京都大田区羽田空港', telephonenumber: '03-5757-8111', access: '実家から車で約2時間', businesshours: '5:00～24:00', price: '飛行機代によって変わる', stay_time: '約2時間', reservation: '完全予約制', rate: 4, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-content1.jpg"), filename:"sample-content1.jpg"), plan_id: plans[0].id },
    {order: '2', hour: '14', minute: '20', place: '那覇空港到着', explanation: '那覇空港は、沖縄県那覇市にある空港。国内線の基幹空港で、空港法第4条第1項第6号に該当する空港として政令で定める空港（国管理空港）に区分される。隣接する航空自衛隊那覇基地の施設が併設され、民間機と自衛隊機が共同で使用する軍民共用の飛行場である。', name: '那覇空港', address: '〒901-0142 沖縄県那覇市鏡水150', telephonenumber: '098-840-1151', access: '羽田から飛行機で約2時間', businesshours: '6:00～24:00', price: '飛行機代によって変わる', stay_time: '約1時間', reservation: '完全予約制', rate: 4.5, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-content2.jpg"), filename:"sample-content2.jpg"), plan_id: plans[0].id }
  ]
)
