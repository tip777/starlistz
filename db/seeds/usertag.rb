#ユーザーののジャンル設定
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

#多数で確認用
9.times do |i|
  if i == 0
    $user_list = ['user_genre1','user_genre2','user_genre3','user_genre4','user_genre5']
  else
    $user_list.push("user_genre1_#{i+2}","user_genre2_#{i+2}","user_genre3_#{i+2}","user_genre4_#{i+2}","user_genre5_#{i+2}")
  end
end
$user_list.each_with_index do |tag, i|
  target = ActsAsTaggableOn::Tag.new(id: i+1, name: tag,)
  target.save
end

user_itiran = User.all
user_itiran.each_with_index do |tag, i|
  # target = ActsAsTaggableOn::Tagging.new(tag_id: i+1, taggable_type: "User", taggable_id: i+1, context: "tags")
  # target.save

  random = Random.new
  n = random.rand(1..50)
  n2 = random.rand(1..50)
  target = ActsAsTaggableOn::Tagging.new(tag_id: n2, taggable_type: "User", taggable_id: n, context: "tags")
  target.save
end
