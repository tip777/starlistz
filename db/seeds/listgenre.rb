#プレイリストのジャンル設定
$list = ""
9.times do |i|
  if i == 0
    $list = ['playlist_genre1','playlist_genre2','playlist_genre3','playlist_genre4','playlist_genre5']
  else
    $list.push("playlist_genre1-#{i+2}","playlist_genre2-#{i+2}","playlist_genre3-#{i+2}","playlist_genre4-#{i+2}","playlist_genre5-#{i+2}")
  end
end
$list.push('all', 'jpop', 'hiphop', 'randb', 'dj', 'edm', 'ロックバンド', 'レゲエ', 'ジャズ', 'クラシック', 'ブルース', 'メタル', 'ボーカロイド')

h = 0
$list.each do |tag|
  h = h + 11
  target = ActsAsTaggableOn::Tag.new(id: h, name: tag,)
  target.save
end

list_itiran = List.all
list_itiran.each_with_index do |tag, i|
  target = ActsAsTaggableOn::Tagging.new(tag_id: i+11, taggable_type: "List", taggable_id: i+1, context: "tags")
  target.save

  random = Random.new
  n = random.rand(1..50)
  n2 = random.rand(61..74)
  target = ActsAsTaggableOn::Tagging.new(tag_id: n2, taggable_type: "List", taggable_id: n, context: "tags")
  target.save
end
