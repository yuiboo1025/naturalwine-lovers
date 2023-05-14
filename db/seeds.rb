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
Member.create!(name: "yui", email: "yui@yui", encrypted_password: "yuiyui", favorite_genre: 5, prefecture: 18, introduction: "ワイン大好きです。", is_deleted: "false")

Member.create!(name: "sakura", email: "sakura@sakura", encrypted_password: "sakurasakura", favorite_genre: 4, prefecture: 13, introduction: "ナチュラルワイン好き!", is_deleted: "false")

Member.create!(name: "hana", email: "hana@hana", encrypted_password: "hanahana", favorite_genre: 2, prefecture: 17, introduction: "白ワイン好きです！", is_deleted: "false")

Member.create!(name: "ume", email: "ume@ume", encrypted_password: "umeume", favorite_genre: 3, prefecture: 15, introduction: "よろしくお願いします", is_deleted: "false")

Member.create!(name: "fuji", email: "fuji@fuji", encrypted_password: "fujifuji", favorite_genre: 0, prefecture: 22, introduction: "仲良くしてください", is_deleted: "false")

Member.create!(name: "sumire", email: "sumire@sumire", encrypted_password: "sumiresumire", favorite_genre: 4, prefecture: 12, introduction: "ワイン仲間増やしたい！", is_deleted: "false")

Member.create!(name: "kiku", email: "kiku@kiku", encrypted_password: "kikukiku", favorite_genre: 1, prefecture: 23, introduction: "", is_deleted: "false")

Member.create!(name: "suzu", email: "suzu@suzu", encrypted_password: "suzusuzu", favorite_genre: 0, prefecture: 1, introduction: "", is_deleted: "false")

Member.create!(name: "popo", email: "popo@popo", encrypted_password: "popopopo", favorite_genre: 5, prefecture: 20, introduction: "", is_deleted: "false")

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
Genre.create!(genre_name:"White")
Genre.create!(genre_name:"Red")
Genre.create!(genre_name:"Rose")
Genre.create!(genre_name:"Orange")
Genre.create!(genre_name:"Sparkling")
Genre.create!(genre_name:"Others")

#wine投稿
Wine.create!(member_id:, genre_id:, spot_id:, wine_name:"", production_country:"", production_year:"", rate:, impression:"", is_again:"")