#ユーザー設定
50.times do |i|
  profile = UserProfile.create(description: "これはユーザープロフィールの説明[ #{i+1} ]")
  user = User.create(id: i+1,name: "test#{i+1}", email: "test#{i}@gmail.com", password: "testtest", password_confirmation: "testtest")
  user.user_profile = profile
  user.save
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