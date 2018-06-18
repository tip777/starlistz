#ユーザー設定
profile = UserProfile.create(description: "これはユーザープロフィールの説明これはユーザープロフィールの説明これはユーザープロフィールの説明これはユーザープロフィールの説明これはユーザープロフィールの説明これはユーザープロフィールの説明これはユーザープロフィールの説明これはユーザープロフィールの説明これはユーザープロフィールの説明これはユーザープロフィールの説明これはユーザープロフィールの説明これはユーザープロフィールの説明これはユーザープロフィールの説明これはユーザープロフィールの説明これはユーザープロフィールの説明これはユーザープロフィールの説明これはユーザープロフィールの説明これはユーザープロフィールの説明これはユーザープロフィールの説明これはユーザープロフィールの説明ユーザープロフィールの説明ユーザープロフィールの説明ユーザープロフィールの説明ユーザープロフィールの説明ユーザープロフィールの説明ユーザープロフィールの説明ユー")
user = User.create(id: 100,name: "testktestktestktestktestkte100", email: "test100@gmail.com", password: "testtest", password_confirmation: "testtest")
user.user_profile = profile
user.save

#フォロー、フォロワー設定
Relationship.create(follower_id: "1", followed_id: "100")
Relationship.create(follower_id: "2", followed_id: "100")
Relationship.create(follower_id: "3", followed_id: "100")
Relationship.create(follower_id: "4", followed_id: "100")
Relationship.create(follower_id: "6", followed_id: "100")
Relationship.create(follower_id: "7", followed_id: "100")
Relationship.create(follower_id: "8", followed_id: "100")
Relationship.create(follower_id: "9", followed_id: "100")
Relationship.create(follower_id: "10", followed_id: "100")


#多数で確認用
$user_list = []
30.times do |i|
    $user_list.push("user_genreuser_genreuser_genreuser_genreuser_genreuser_genreuser_genreuser_genreuser_genreuser_gen#{format("%04d", i)}")
end
$user_list.each_with_index do |tag, i|
  target = ActsAsTaggableOn::Tag.new(id: 200+i, name: tag)
  target.save
end

$user_list.each_with_index do |tag, i|
  target = ActsAsTaggableOn::Tagging.new(tag_id: 200+i, taggable_type: "User", taggable_id: 100, context: "tags")
  target.save
end

List.create(id: 100,user_id: 100, title: "プレイリストプレイリストプレイリストプレイリストプレイリストプレイリストプレイリストプレイリスMAX", description: "プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明プレイリストの説明あMAX", price: 1300)

# 10.times do |i|
#   ListFavorite.create(user_id: i, list_id: 100)
# end


15.times do |i|
  random = Random.new
  if i == random.rand(1..15)
    Track.create(list_id: i+1, artist: "アーティストアーティストアーティストアーティストアーティストアーティストアーティストアーティスト#{format("%04d", i)}", song: "ソングソングソングソングソングソングソングソングソングソングソングソングソングソングソングソング#{format("%04d", i)}", description: "この曲のバースはハンパじゃない。昔から聞いてるけどバース１のパンチラインが何回聞いても癖になる！この曲のバースはハンパじゃない。昔から聞いてるけどバース１のパンチラインが何回聞いても癖になる！この曲のバースはハンパじゃない。昔から聞いてるけどバース１のパンチラインが何回聞いても癖になる！この曲のバースはハンパじゃない。昔から聞いてるけどバース１のパンチラインが何回聞いても癖になる！この曲のバースはハンパじゃない。昔から聞いてるけどバース１のパンチラインが何回聞いても癖になる！この曲のバースはハンパじゃない。昔から聞いてるけどバース１のパンチラインが何回聞いても癖になる！この曲のバースはハンパじゃない。昔から聞いてるけどバース１のパンチラインが何回聞いても癖になる！この曲のバースはハンパじゃない。昔から聞いてるけどバース１のパンチラインが何回聞いても癖になる！昔から聞いてるけどバース１の#{format("%04d", i)}", recommend: true, row_order: i+1)
  else
    Track.create(list_id: i+1, artist: "アーティストアーティストアーティストアーティストアーティストアーティストアーティストアーティスト#{format("%04d", i)}", song: "ソングソングソングソングソングソングソングソングソングソングソングソングソングソングソングソング#{format("%04d", i)}", description: "この曲のバースはハンパじゃない。昔から聞いてるけどバース１のパンチラインが何回聞いても癖になる！この曲のバースはハンパじゃない。昔から聞いてるけどバース１のパンチラインが何回聞いても癖になる！この曲のバースはハンパじゃない。昔から聞いてるけどバース１のパンチラインが何回聞いても癖になる！この曲のバースはハンパじゃない。昔から聞いてるけどバース１のパンチラインが何回聞いても癖になる！この曲のバースはハンパじゃない。昔から聞いてるけどバース１のパンチラインが何回聞いても癖になる！この曲のバースはハンパじゃない。昔から聞いてるけどバース１のパンチラインが何回聞いても癖になる！この曲のバースはハンパじゃない。昔から聞いてるけどバース１のパンチラインが何回聞いても癖になる！この曲のバースはハンパじゃない。昔から聞いてるけどバース１のパンチラインが何回聞いても癖になる！昔から聞いてるけどバース１の#{format("%04d", i)}", recommend: false, row_order: i+1)
  end
end

#多数で確認用
$list_list = []
30.times do |i|
    $list_list.push("list_genrelist_genrelist_genrelist_genrelist_genrelist_genrelist_genrelist_genrelist_genrelist_gen#{format("%04d", i)}")
end

$list_list.each_with_index do |tag, i|
  target = ActsAsTaggableOn::Tag.new(id: 300+i, name: tag)
  target.save
end

$list_list.each_with_index do |tag, i|
  target = ActsAsTaggableOn::Tagging.new(tag_id: 300+i, taggable_type: "List", taggable_id: 100, context: "tags")
  target.save
end
