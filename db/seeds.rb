# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#User
# 10.times do |i|
#     User.create(email: "test#{i+1}@example.com",   password: "password", name: "test#{i+1}")
#     if (i+1).even?
#         UserProfile.create(user_id: "#{i+1}", description: "これはユーザープロフィールの説明[ #{i+1} ]", insta_url: "https://www.instagram.com/tkpa2/?hl=ja", tw_url: "https://twitter.com/starlistz", avatar: File.new("app/assets/images/avatar/NO#{i+1}.jpg"))
#     else
#         UserProfile.create(user_id: "#{i+1}", description: "これはユーザープロフィールの説明[ #{i+1} ]", insta_url: "", tw_url: "", avatar: File.new("app/assets/images/avatar/NO#{i+1}.jpg"))
#     end
#
#     #List
#     List.create(user_id: "#{i+1}", name: "プレイリスト #{i+1}", description: "プレイリストの説明 #{i+1}", price: 100)
#     ListFavorite.create(list_id: "#{i+1}", user_id: "#{i+1}")
#
#     if i+1 == rand(9)+1
#       ListItem.create(artist: "#{i+1}", song: "#{i+1}", favorite: "1")
#     else
#       ListItem.create(artist: "#{i+1}", song: "#{i+1}", favorite: "")
#     end
#
#     ItemService.create(music_service_id: "#{i+1}", list_item_id: "#{i+1}")
#     MusicService.create(name: "ミュージックサービス #{i+1}", url: "https://itunes.apple.com/jp/album/the-beatles-box-set/id402060584?uo=4")
#     Purchase.create(order_date: "2017-7-#{i+1}", user_id: "#{i+1}", list_id: "#{i+1}")
# end
# UserFavorite.create(favoriting_id: "1", favorited_id: "2")
# UserFavorite.create(favoriting_id: "2", favorited_id: "3")
# UserFavorite.create(favoriting_id: "3", favorited_id: "4")
# UserFavorite.create(favoriting_id: "4", favorited_id: "5")
# UserFavorite.create(favoriting_id: "5", favorited_id: "6")
# UserFavorite.create(favoriting_id: "6", favorited_id: "7")
# UserFavorite.create(favoriting_id: "7", favorited_id: "8")
# UserFavorite.create(favoriting_id: "8", favorited_id: "9")
# UserFavorite.create(favoriting_id: "9", favorited_id: "10")
# UserFavorite.create(favoriting_id: "10", favorited_id: "1")



# 10.time do |i|
#   User.create(name: 'test#{i}',email: 'test#{i}@gmail.com', password: 'testtest#{i}', password_confirmation: 'testtest#{i}')
# end

5.times do |i|
  # binding.pry
  List.create(user_id: 1, title: "プレイリスト #{i+1}", description: "プレイリストの説明 #{i+1}", price: "#{i}00")
end

5.times do |i|
  15.times do |n|
    random = Random.new
    if i == random.rand(1..15)
      Track.create(list_id: i, artist: "アーティスト #{n+1}", song: "ソング #{n+1}", recommend: true, no: n+1)
    else
      Track.create(list_id: i, artist: "アーティスト #{n+1}", song: "ソング #{n+1}", recommend: false, no: n+1)
    end
  end
end
