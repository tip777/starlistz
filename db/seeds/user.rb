#ユーザー設定
10.times do |i|
  profile = UserProfile.create(description: "これはユーザープロフィールの説明[ #{i+1} ]")
  user = User.create(id: i+1,name: "test#{i+1}", email: "test#{i}@gmail.com", password: "testtest", password_confirmation: "testtest")
  user.user_profile = profile
  user.save
end

#ユーザーののジャンル設定
$user_list = ""
$user_list = ['カメラマン','dj','trainer','インスタグラマー','artist','singer','アーティスト','rapper','らっぱー','芸能人']
$user_list.each_with_index do |tag, i|
  target = ActsAsTaggableOn::Tag.new(id: i+1, name: tag,)
  target.save
end

15.times do |i|
  random = Random.new
  n = random.rand(1..10)
  n2 = random.rand(1..10)
  target2 = ActsAsTaggableOn::Tagging.new(tag_id: n, taggable_type: "User", taggable_id: n2, context: "tags")
  target2.save
end

#フォロー、フォロワー設定
Relationship.create(follower_id: "1", followed_id: "2")
Relationship.create(follower_id: "2", followed_id: "3")
Relationship.create(follower_id: "3", followed_id: "4")
Relationship.create(follower_id: "4", followed_id: "5")
Relationship.create(follower_id: "6", followed_id: "7")
Relationship.create(follower_id: "7", followed_id: "8")
Relationship.create(follower_id: "8", followed_id: "9")
Relationship.create(follower_id: "9", followed_id: "10")
Relationship.create(follower_id: "10", followed_id: "1")