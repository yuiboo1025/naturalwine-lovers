# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#管理者
Admin.create!(email: "admin@admin", password: "adminadmin")

#ユーザー
Member.create!(name: "yui", email: "yui@yui", encrypted_password: "yuiyui", favorite_genre: 5, prefecture: 18, introduction: "ワイン大好きです。", is_deleted: "false", profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/profile_image/yui.jpg")),filename: 'yui.jpg'))

Member.create!(name: "sakura", email: "sakura@sakura", encrypted_password: "sakurasakura", favorite_genre: 4, prefecture: 13, introduction: "ナチュラルワイン好き!", is_deleted: "false", profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/profile_image/sakura.jpg")),filename: 'sakura.jpg'))

Member.create!(name: "hana", email: "hana@hana", encrypted_password: "hanahana", favorite_genre: 2, prefecture: 17, introduction: "白ワイン好きです！", is_deleted: "false", profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/profile_image/hana.jpg")),filename: 'hana.jpg'))

Member.create!(name: "ume", email: "ume@ume", encrypted_password: "umeume", favorite_genre: 3, prefecture: 15, introduction: "よろしくお願いします", is_deleted: "false", profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/profile_image/ume.jpg")),filename: 'ume.jpg'))

Member.create!(name: "fuji", email: "fuji@fuji", encrypted_password: "fujifuji", favorite_genre: 0, prefecture: 22, introduction: "仲良くしてください", is_deleted: "false", profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/profile_image/fuji.jpg")),filename: 'fuji.jpg'))

Member.create!(name: "sumire", email: "sumire@sumire", encrypted_password: "sumiresumire", favorite_genre: 4, prefecture: 12, introduction: "ワイン仲間増やしたい！", is_deleted: "false", profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/profile_image/sumire.jpg")),filename: 'sumire.jpg'))

Member.create!(name: "kiku", email: "kiku@kiku", encrypted_password: "kikukiku", favorite_genre: 1, prefecture: 23, introduction: "", is_deleted: "false", profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/profile_image/kiku.jpg")),filename: 'kiku.jpg'))

Member.create!(name: "suzu", email: "suzu@suzu", encrypted_password: "suzusuzu", favorite_genre: 0, prefecture: 1, introduction: "", is_deleted: "false", profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/profile_image/suzu.jpg")),filename: 'suzu.jpg'))

Member.create!(name: "popo", email: "popo@popo", encrypted_password: "popopopo", favorite_genre: 5, prefecture: 20, introduction: "", is_deleted: "false", profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/profile_image/popo.jpg")),filename: 'popo.jpg'))

#フォロー(member1中心)
Relationship.create!(follower_id:1,followed_id:2)
Relationship.create!(follower_id:2,followed_id:1)
Relationship.create!(follower_id:1,followed_id:3)
Relationship.create!(follower_id:3,followed_id:1)
Relationship.create!(follower_id:1,followed_id:4)
Relationship.create!(follower_id:4,followed_id:1)
Relationship.create!(follower_id:1,followed_id:5)
Relationship.create!(follower_id:5,followed_id:1)
Relationship.create!(follower_id:1,followed_id:6)
Relationship.create!(follower_id:6,followed_id:1)
Relationship.create!(follower_id:1,followed_id:7)
Relationship.create!(follower_id:7,followed_id:1)
Relationship.create!(follower_id:1,followed_id:8)
Relationship.create!(follower_id:8,followed_id:1)
#フォロー(member2中心)
Relationship.create!(following_id:2,follower_id:5)
Relationship.create!(following_id:5,follower_id:2)
Relationship.create!(following_id:2,follower_id:6)
Relationship.create!(following_id:6,follower_id:2)

#spot作成
Spot.create!(spot_name:"家庭料理とワインの店kuwabara", address:"新潟県新潟市中央区南笹口１丁目１−３８ コープオリンピア笹口 1F", lat:"37.9076", lng:"139.065")
Spot.create!(spot_name:"LE HACO（ルアコ）", address:"静岡県浜松市中区鍛冶町２−７", lat:"34.7034", lng:"137.732")
Spot.create!(spot_name:"STAMM", address:"大阪府茨木市駅前３丁目６−２ BOXFIVE 2F", lat:"34.8168", lng:"135.568")
Spot.create!(spot_name:"ビストロユイガ BISTRO YUIGA", address:"石川県金沢市水溜町４−１ ビストロユイガ", lat:"36.5564", lng:"136.654")
Spot.create!(spot_name:"Wine Stand Waltz", address:"東京都渋谷区恵比寿４丁目２４−３ 島田ビル 1F", lat:"35.6454", lng:"139.716")
Spot.create!(spot_name:"バーこうみんかん", address:"福井県福井市中央１丁目２２−７ 西脇ビル 2F", lat:"36.0599", lng:"136.221")
Spot.create!(spot_name:"ｒｉｔｍｏ", address:"栃木県宇都宮市駅前通り２丁目１−９", lat:"36.5582", lng:"139.896")
Spot.create!(spot_name:"iomare（イオマレ）", address:"石川県金沢市高岡町１８−２", lat:"36.5665", lng:"136.652")

#ワインジャンル
Genre.create!(genre_name: "White")
Genre.create!(genre_name: "Red")
Genre.create!(genre_name: "Rose")
Genre.create!(genre_name: "Orange")
Genre.create!(genre_name: "Sparkling")
Genre.create!(genre_name: "Others")

#wine投稿
#yuiの投稿
Wine.create!(member_id: 2, genre_id: 2, spot_id: 6, wine_name: "Giandon", production_country: "イタリア", production_year: "不明", rate: 5.0, impression :"ラベルが可愛い", is_again: true, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/yui_1.jpeg")),filename: 'yui_1.jpeg'))
Wine.create!(member_id: 2, genre_id: 3, spot_id: 6, wine_name: "Weeping Juan", production_country: "オーストラリア", production_year: "2022", rate: 4.0, impression:"ピンク色ではないけどロゼワイン！", is_again: true, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/yui_2.jpeg")),filename: 'yui_2.jpeg'))
Wine.create!(member_id: 2, genre_id: 4, spot_id: 6, wine_name: "Lunaria", production_country: "イタリア", production_year: "不明", rate: 3.0, impression: "色濃いめのオレンジワイン", is_again: true, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/yui_3.jpeg")),filename: 'yui_3.jpeg'))
Wine.create!(member_id: 2, genre_id: 2, spot_id: 6, wine_name: "Libre Pensée", production_country: "フランス", production_year: "2019", rate: 3.0, impression: "チョコに合う！", is_again: false, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/yui_4.jpeg")),filename: 'yui_4.jpeg'))
Wine.create!(member_id: 2, genre_id: 2, spot_id: 4, wine_name: "不明", production_country: "不明", production_year: "不明", rate: 5.0, impression: "ラベルがおしゃれすぎる。。", is_again: true, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/yui_5.jpeg")),filename: 'yui_5.jpeg'))
Wine.create!(member_id: 2, genre_id: 1, spot_id: 4, wine_name: "Fidesser Sauvignon blanc", production_country: "オーストラリア", production_year: "2020", rate: 4.0, impression: "飲みやすい", is_again: false, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/yui_6.jpeg")),filename: 'yui_6.jpeg'))
Wine.create!(member_id: 2, genre_id: 2, spot_id: 1, wine_name: "Cariboum 2017 SARL l'Octavian", production_country: "フランス", production_year: "2017", rate: 5.0, impression: "可愛すぎるサンタ柄", is_again: true, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/yui_7.jpeg")),filename: 'yui_7.jpeg'))
Wine.create!(member_id: 2, genre_id: 2, spot_id: 1, wine_name: "Heiter Bis Wolkig", production_country: "ドイツ", production_year: "不明", rate: 3.0, impression: "", is_again: false, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/yui_8.jpeg")),filename: 'yui_8.jpeg'))

#sakuraの投稿
Wine.create!(member_id: 3, genre_id: 1, spot_id: 7, wine_name: "Soumah Chardonnay d'Soumah", production_country: "オーストラリア", production_year: "2021", rate: 3.0, impression: "飲みやすい", is_again: false, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/sakura_5.jpeg")),filename: 'sakura_5.jpeg'))
Wine.create!(member_id: 3, genre_id: 1, spot_id: 7, wine_name: "Els Bassotets", production_country: "スペイン", production_year: "2018", rate: 4.0, impression: "	濁りがあって美味しい！", is_again: true, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/sakura_4.jpeg")),filename: 'sakura_4.jpeg'))
Wine.create!(member_id: 3, genre_id: 2, spot_id: 5, wine_name: "不明", production_country: "フランス", production_year: "2021", rate: 4.0, impression: "重め", is_again: false, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/sakura_3.jpeg")),filename: 'sakura_3.jpeg'))
Wine.create!(member_id: 3, genre_id: 3, spot_id: 5, wine_name: "Cerdon", production_country: "フランス", production_year: "2021", rate: 5.0, impression: "色も綺麗でグビグビ飲んじゃう", is_again: true, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/sakura_2.jpeg")),filename: 'sakura_2.jpeg'))
Wine.create!(member_id: 3, genre_id: 1, spot_id: 5, wine_name: "Little Bastard", production_country: "ドイツ", production_year: "2018", rate: 4.0, impression: "柑橘の香り！", is_again: true, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/sakura_1.jpeg")),filename: 'sakura_1.jpeg'))

#hanaの投稿
Wine.create!(member_id: 4, genre_id: 1, spot_id: 4, wine_name: "Baudili", production_country: "スペイン", production_year: "2019", rate: 4.0, impression: "美味しかった", is_again: true, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/hana_6.jpeg")),filename: 'hana_6.jpeg'))
Wine.create!(member_id: 4, genre_id: 1, spot_id: 8, wine_name: "Edel", production_country: "フランス", production_year: "2020", rate: 4.0, impression: "", is_again: false, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/hana_5.jpeg")),filename: 'hana_5.jpeg'))
Wine.create!(member_id: 4, genre_id: 2, spot_id: 8, wine_name: "Bonarda Il Vei", production_country: "イタリア", production_year: "不明", rate: 4.0, impression: "オレンジ色っぽい", is_again: true, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/hana_4.jpeg")),filename: 'hana_4.jpeg'))
Wine.create!(member_id: 4, genre_id: 2, spot_id: 8, wine_name: "不明", production_country: "フランス", production_year: "不明", rate: 3.0, impression: "", is_again: false, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/hana_3.jpeg")),filename: 'hana_3.jpeg'))
Wine.create!(member_id: 4, genre_id: 1, spot_id: 8, wine_name: "Les Ardilles", production_country: "フランス", production_year: "2020", rate: 4.0, impression: "お肉に合う", is_again: true, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/hana_2.jpeg")),filename: 'hana_2.jpeg'))
Wine.create!(member_id: 4, genre_id: 4, spot_id: 3, wine_name: "Try'O", production_country: "フランス", production_year: "2020", rate: 5.0, impression: "少し渋い", is_again: true, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/hana_1.jpeg")),filename: 'hana_1.jpeg'))

#umeの投稿
Wine.create!(member_id: 5, genre_id: 1, spot_id: 1, wine_name: "FUNPY", production_country: "不明", production_year: "不明", rate: 3.0, impression: "色が綺麗", is_again: false, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/ume_3.jpeg")),filename: 'ume_3.jpeg'))
Wine.create!(member_id: 5, genre_id: 4, spot_id: 1, wine_name: "ヴィーノビアンコ", production_country: "イタリア", production_year: "不明", rate: 5.0, impression: "綺麗なオレンジ色！", is_again: true, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/ume_2.jpeg")),filename: 'ume_2.jpeg'))
Wine.create!(member_id: 5, genre_id: 3, spot_id: 1, wine_name: "RIESLING GLOUGLOU", production_country: "フランス", production_year: "2018", rate: 3.0, impression: "飲みやすい", is_again: true, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/ume_1.jpeg")),filename: 'ume_1.jpeg'))

#fujiの投稿
Wine.create!(member_id: 6, genre_id: 1, spot_id: 2, wine_name: "Malvasia IL VEI", production_country: "イタリア", production_year: "2021", rate: 5.0, impression: "横画像でも投稿できます。", is_again: true, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/ume_1.jpeg")),filename: 'ume_1.jpeg'))
Wine.create!(member_id: 6, genre_id: 3, spot_id: 2, wine_name: "Frauen Power", production_country: "ドイツ", production_year: "2021", rate: 5.0, impression: "飲みやすくてラベルがポップ！", is_again: true, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/ume_2.jpeg")),filename: 'ume_2.jpeg'))
Wine.create!(member_id: 6, genre_id: 2, spot_id: 2, wine_name: "FOLIES ROUGE", production_country: "不明", production_year: "2018", rate: 4.0, impression: "ラベルが印象的", is_again: false, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/ume_3.jpeg")),filename: 'ume_3.jpeg'))
Wine.create!(member_id: 6, genre_id: 2, spot_id: 2, wine_name: "Les Petites Fleurs", production_country: "フランス", production_year: "2021", rate: 1.0, impression: "苦味がある", is_again: false, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/wine_image/ume_4.jpeg")),filename: 'ume_4.jpeg'))

