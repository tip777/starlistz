#プレイリストのジャンル設定
$list = ""
4.times do |i|
  if i == 0
    $list = ['playlist_genre1','playlist_genre2','playlist_genre3','playlist_genre4','playlist_genre5']
  else
    $list.push("playlist_genre1_#{i+2}","playlist_genre2_#{i+2}","playlist_genre3_#{i+2}","playlist_genre4_#{i+2}","playlist_genre5_#{i+2}")
  end
end
$list.push('all', 'jpop', 'hiphop', 'randb', 'dj', 'edm', 'ロックバンド', 'レゲエ', 'ジャズ', 'クラシック', 'ブルース', 'メタル', 'ボーカロイド')

h = 10
$list.each do |tag|
  h = h + 1
  target = ActsAsTaggableOn::Tag.new(id: h, name: tag,)
  target.save
end
