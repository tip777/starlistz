# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# #ユーザー設定
# 10.times do |i|
#   profile = UserProfile.create(description: "これはユーザープロフィールの説明[ #{i+1} ]")
#   user = User.create(id: i+1,name: "test#{i+1}", email: "test#{i}@gmail.com", password: "testtest", password_confirmation: "testtest")
#   user.user_profile = profile
#   user.save
# end

# #ユーザーののジャンル設定
# $user_list = ""
# $user_list = ['カメラマン','dj','trainer','インスタグラマー','artist','singer','アーティスト','rapper','らっぱー','芸能人']
# $user_list.each_with_index do |tag, i|
#   target = ActsAsTaggableOn::Tag.new(id: i+1, name: tag,)
#   target.save
# end

# 15.times do |i|
#   random = Random.new
#   n = random.rand(1..10)
#   n2 = random.rand(1..10)
#   target2 = ActsAsTaggableOn::Tagging.new(tag_id: n, taggable_type: "User", taggable_id: n2, context: "tags")
#   target2.save
# end


# #フォロー、フォロワー設定
# Relationship.create(follower_id: "1", followed_id: "2")
# Relationship.create(follower_id: "2", followed_id: "3")
# Relationship.create(follower_id: "3", followed_id: "4")
# Relationship.create(follower_id: "4", followed_id: "5")
# Relationship.create(follower_id: "6", followed_id: "7")
# Relationship.create(follower_id: "7", followed_id: "8")
# Relationship.create(follower_id: "8", followed_id: "9")
# Relationship.create(follower_id: "9", followed_id: "10")
# Relationship.create(follower_id: "10", followed_id: "1")

# #プレイリスト作成
# h = 0
# 10.times do |i|
#   5.times do |n|
#     h = h + 1
#     List.create(id: h,user_id: i+1, title: "プレイリスト #{h}", description: "プレイリストの説明 #{h}", price: "#{n}00")
#   end
# end

# #プレイリストお気に入り設定
# 40.times do |i|
#   random = Random.new
#   n = random.rand(1..10)
#   n2 = random.rand(1..50)
#   ListFavorite.create(user_id: n, list_id: n2)
# end

# #曲設定
# 5.times do |i|
#   15.times do |n|
#     random = Random.new
#     if i == random.rand(1..15)
#       Track.create(list_id: i+1, artist: "アーティスト #{n+1}", song: "ソング #{n+1}", recommend: true, row_order: n+1)
#     else
#       Track.create(list_id: i+1, artist: "アーティスト #{n+1}", song: "ソング #{n+1}", recommend: false, row_order: n+1)
#     end
#   end
# end

# #プレイリストのジャンル設定
# $list = ""
# 9.times do |i|
#   if i == 0
#     $list = ['playlist_genre1','playlist_genre2','playlist_genre3','playlist_genre4','playlist_genre5']
#   else
#     $list.push("playlist_genre1-#{i+2}","playlist_genre2-#{i+2}","playlist_genre3-#{i+2}","playlist_genre4-#{i+2}","playlist_genre5-#{i+2}")
#   end
# end
# $list.push('all', 'jpop', 'hiphop', 'randb', 'dj', 'edm', 'ロックバンド', 'レゲエ', 'ジャズ', 'クラシック', 'ブルース', 'メタル', 'ボーカロイド')

# h = 0
# $list.each do |tag|
#   h = h + 11
#   target = ActsAsTaggableOn::Tag.new(id: h, name: tag,)
#   target.save
# end

# list_itiran = List.all
# list_itiran.each_with_index do |tag, i|
#   target = ActsAsTaggableOn::Tagging.new(tag_id: i+11, taggable_type: "List", taggable_id: i+1, context: "tags")
#   target.save

#   random = Random.new
#   n = random.rand(1..50)
#   n2 = random.rand(61..74)
#   target = ActsAsTaggableOn::Tagging.new(tag_id: n2, taggable_type: "List", taggable_id: n, context: "tags")
#   target.save
# end
