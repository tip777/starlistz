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



# #heroku用に少なめに
# #プレイリスト作成
# h = 0
# 10.times do |i|
#   5.times do |n|
#     h = h + 1
#     List.create(id: h,user_id: i+1, title: "プレイリスト #{h}", description: "プレイリストの説明 #{h}プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明", price: "#{n}00")
#   end
# end

# #プレイリストお気に入り設定
# 20.times do |i|
#   random = Random.new
#   n = random.rand(1..10)
#   n2 = random.rand(1..20)
#   ListFavorite.create(user_id: n, list_id: n2)
# end

# #曲設定
# 2.times do |i|
#   15.times do |n|
#     random = Random.new
#     if i == random.rand(1..15)
#       Track.create(list_id: i+1, artist: "アーティスト #{n+1}", song: "ソング #{n+1}", description: "この曲のバースはハンパじゃない。昔から聞いてるけどバース１のパンチラインが何回聞いても癖になる！！", recommend: true, row_order: n+1)
#     else
#       Track.create(list_id: i+1, artist: "アーティスト #{n+1}", song: "ソング #{n+1}", recommend: false, row_order: n+1)
#     end
#   end
# end



#売上管理確認用
#プレイリスト作成
h = 0
5.times do |i|
  10.times do |n|
    h = h + 1
    List.create(id: h,user_id: i+1, title: "プレイリスト #{h}", description: "プレイリストの説明 #{h}プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明", price: (n+1) * 100)
  end
end

# binding.pry

#プレイリストお気に入り設定
# 20.times do |i|
#   random = Random.new
#   n = random.rand(1..10)
#   n2 = random.rand(1..20)
#   ListFavorite.create(user_id: n, list_id: n2)
# end

#曲設定n
2.times do |i|
  15.times do |n|
    random = Random.new
    if i == random.rand(1..15)
      Track.create(list_id: i+1, artist: "アーティスト #{n+1}", song: "ソング #{n+1}", description: "この曲のバースはハンパじゃない。昔から聞いてるけどバース１のパンチラインが何回聞いても癖になる！！", recommend: true, row_order: n+1)
    else
      Track.create(list_id: i+1, artist: "アーティスト #{n+1}", song: "ソング #{n+1}", recommend: false, row_order: n+1)
    end
  end
end

