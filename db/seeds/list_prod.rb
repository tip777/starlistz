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

tracks = %w(米津玄師 米津玄師 宇多田ヒカル DA\ PUMP back\ number 宇多田ヒカル 米津玄師 関取花 あいみょん 関ジャニ∞ King\ &\ Prince あいみょん 乃木坂46 米津玄師 Aimer 平井堅 あいみょん 米津玄師 RATS＆STAR 平井堅 MONGOL800 Suchmos 関取花 関取花 宇多田ヒカル 関取花 LIP×LIP 関取花 WANIMA 関取花 米津玄師 back\ number RADWIMPS WANIMA back\ number 宇多田ヒカル GReeeeN ヨルシカ スキマスイッチ Aimer 関取花 米津玄師 DAOKO×米津玄師 WANIMA miwa あいみょん back\ number TWICE WANIMA RADWIMPS SEKAI\ NO\ OWARI Mr.Children back\ number 嵐 関取花 欅坂46 関取花 TWICE 関取花 童謡・唱歌 米津玄師 欅坂46 宇多田ヒカル 米津玄師 SHISHAMO 高橋優 HY 米津玄師 サザンオールスターズ 福山雅治 あいみょん 関取花 関取花 伊弉冉一二三(木島隆一) 関取花 t-Ace 小田和正 [ALEXANDROS] My\ Hair\ is\ Bad あいみょん NEWS UVERworld 米津玄師 SEKAI\ NO\ OWARI flumpool miwa Suchmos X\ JAPAN 嵐 ゲスの極み乙女。 DA\ PUMP 嵐 Radio\ Bestsellers 女王蜂 宇多田ヒカル 絢香 三代目\ J\ Soul\ Brothers\ from\ EXILE\ TRIBE IDOLiSH7 平井堅 観音坂独歩(伊東健人) 関取花 米津玄師 関ジャニ∞ 宇多田ヒカル 米津玄師 ONE\ OK\ ROCK back\ number TWICE 宇多田ヒカル 米津玄師 sumika 米津玄師 嵐 宇多田ヒカル KAT-TUN 家入レオ 米津玄師 IDOLiSH7 WANIMA 関取花 ケツメイシ JUJU back\ number EXILE back\ number Mrs.\ GREEN\ APPLE ONE\ OK\ ROCK back\ number 西野カナ サザンオールスターズ 安室奈美恵 欅坂46 Mrs.\ GREEN\ APPLE 米津玄師 ヨルシカ 宇多田ヒカル 米米CLUB 米津玄師 back\ number back\ number あいみょん アンジェラ・アキ SEKAI\ NO\ OWARI back\ number コブクロ C&K シェネル 倖田來未 関ジャニ∞ GENERATIONS\ from\ EXILE\ TRIBE WANIMA 関取花 Little\ Glee\ Monster WANIMA 宇多田ヒカル 宇多田ヒカル 関ジャニ∞ back\ number 西野カナ 平井大 大山のぶ代 宇多田ヒカル 関取花 シェネル NEWS Superfly コブクロ DEAN\ FUJIOKA 浦島坂田船 夏川りみ DREAMS\ COME\ TRUE 中西保志 米津玄師 米津玄師 有栖川帝統(野津山幸宏) 欅坂46 乃木坂46 BTS\ (防弾少年団) AAA back\ number TRIGGER 米津玄師 坂本九 サザンオールスターズ RADWIMPS 関取花 いきものがかり スキマスイッチ 関取花 絢香＆三浦大知 BTS\ (防弾少年団) BTS\ (防弾少年団) さだまさし AAA 高橋優 平井堅 RADWIMPS DREAMS\ COME\ TRUE 嵐 JY )
artists = %w(Lemon LOSER 初恋 U.S.A. 瞬き あなた 灰色と青\ (\ +\ 菅田将暉) あの子はいいな 愛を伝えたいだとか Heavenly\ Psycho シンデレラガール 貴方解剖純愛歌\ ～死ね～ シンクロニシティ orion カタオモイ 知らないんでしょ？ 君はロックを聴かない ピースサイン め組のひと ノンフィクション 小さな恋のうた 808 もしも僕に 蛍 Play\ A\ Love\ Song べつに ロメオ しんきんガール ともに めんどくさいのうた アイネクライネ クリスマスソング スパークル\ [original\ ver.] シグナル 花束 真夏の通り雨 キセキ ヒッチコック 奏(かなで) 蝶々結び 親知らず 春雷 打上花火 やってみよう 夜空。feat.\ ハジ→ 生きていたんだよな ハッピーエンド TT\ -Japanese\ ver.- いいから 前前前世\ (movie\ ver.) サザンカ HANABI わたがし One\ Love むすめ サイレントマジョリティー また今日もダメでした Wake\ Me\ Up バイバイ たなばたさま 砂の惑星\ (\ +\ 初音ミク) 不協和音 誓い ゴーゴー幽霊船 明日も BEAUTIFUL 366日 打上花火 真夏の果実 家族になろうよ 満月の夜なら はつ恋 なんとかなるんで シャンパンゴールド 動けない 超ヤバい この道を ワタリドリ 真赤 ふたりの世界 BLUE ODD\ FUTURE 飛燕 RPG 君に届け ヒカリヘ STAY\ TUNE 紅 Find\ The\ Answer オンナは変わる if... 果てない空 栞 HALF 花束を君に 三日月 恋と愛 MONSTER\ GENERATiON 魔法って言っていいかな？ チグリジア オールライト かいじゅうのマーチ NOROSHI Too\ Proud\ featuring\ Jevon MAD\ HEAD\ LOVE Wherever\ you\ are 高嶺の花子さん Candy\ Pop 嫉妬されるべき人生 ナンバーナイン フィクション Nighthawks I'll\ be\ there パクチーの唄 Real\ Face 君がくれた夏 vivi ナナツイロ\ REALiZE THANX 僕らの口癖 友よ～この先もずっと… やさしさで溢れるように SISTER Turn\ Back\ Time\ feat.\ FANTASTICS 僕は君の事が好きだけど君は僕を別に好きじゃないみたい StaRt Change 僕の名前を あなたの好きなところ 闘う戦士(もの)たちへ愛を込めて Hope ガラスを割れ！ WanteD!\ WanteD! Alice 言って。 道 浪漫飛行 メトロノーム 青い春 ヒロイン マリーゴールド 手紙\ ～拝啓\ 十五の君へ～ RAIN 君の恋人になったら 未来 みかんハート 君に贈る歌\ ～Song\ For\ You め組のひと オモイダマ 涙 CHARM それでもいいならくれてやる いつかこの涙が Drive Forevermore 夕凪 LIFE～目の前の向こうへ～ 恋 アイラブユー Slow\ &\ Easy ドラえもんえかきうた 残り香 さらばコットンガール Happiness 夜よ踊れ 愛をこめて花束を 赤い糸 Echo わいふぁい暴想ボーイ 涙そうそう 未来予想図II 最後の雨 Moonlight クランベリーとパンケーキ 3$EVEN 二人セゾン 裸足でSummer I\ NEED\ U\ (Japanese\ Ver.) 愛してるのに、愛せない 手紙 DAYBREAK\ INTERLUDE アンビリーバーズ 見上げてごらん夜の星を LOVE\ AFFAIR\ ～秘密のデート 夢灯籠 三月を越えて ありがとう 全力少年 朝 ハートアップ DNA\ -Japanese\ ver.- Spring\ Day\ -Japanese\ ver.- あなたへ さよならの前に 明日はきっといい日になる トドカナイカラ スパークル\ (movie\ ver.) 7月7日、晴れ Happiness 好きな人がいること )
des_str = %w(ロード･アイ･ミス･ユー\
「ジャッジャッジャッジャジャ」ってギターで始まる曲。この時代は聴きやすいギターポップだったんだなあ。\
Mr.Shining\ Moon\
90年代の香りを感じる、こなれた一品。\
君がいた夏\
記念すべき1stシングル、メロディの良さは既に今にも繋がるものを感じますよね。ホッとするようなスライドギターが癖になる。 虹の彼方へ\
ギターのカッティングとベースラインめっさおしゃれやん?\
2ndシングルにして早くも一発花火上がったよ。「終わった恋の　心の傷あとは」の「は～」の裏声とともに果ててしまいたい。\
こういう曲のジャンルって何になるんですか?めちゃくちゃ大好物だから教えて欲しい。派手じゃないんだけど、なんだかこっそりスキップしたくなる感じ。\
車の中でかくれてキスをしよう\
車の中で隠れてキスするって字面ではエロい!へへっ!って感じなのに、どうしてここまで悲しく寂しく感じられるのか。歌詞以上にメロディと音楽が語る曲。\
思春期の夏～君との恋が今も牧場に～\
\ ミスチルがツインボーカルのバンドだって知ってました?\
\ 星になれたら\
すみません、田舎から都会に出てきた僕にとってこの曲は、完全に俺のこと歌ってるやんってなる。さよならの曲なのに悲しいくらいにポップで明るい曲調なのがズルいよね。\
かっちりアルバムを締めるバラード。 Another\ Mind\
いよいよミスチルの音楽性が表出した!って曲。無骨にアコギで曲を進めていく感じたまらん。\
メインストリートに行こう\
いつ聴いたってウキウキする。リズムに合わせて自然と手拍子叩いて体を揺らしちゃう。\
ミスチル流ポップファンク。マイクスタンド使って歌いたい。\
甘酸っぱさ全開!\
マーマレード･キッス\
RPGゲームのBGMにありそうな不思議なメロディ。\
蜃気楼\
ミスチルにこんな曲あったんやなと。紳士的なベースのフレーズがドキドキする。\
逃亡者\
\ ミスチルのもう一人のボーカル、声が甘酸っぱい感じがします。\
\ my\ life\
別れの曲なのに、ポップ。ミスチル必殺の「歌詞とメロディ相反する」の確立。 たまらんよ、ポップで愁いを帯びたイントロが。メロディも相まって、歌詞が凄く響く。「lookin'\ for\ love　今建ち並ぶ」「『ticket\ to\ ride』あきれるくらい」と、さらっと韻を踏む小粋さも、「真冬のひまわりのように　鮮やかに揺れてる　過ぎ去った季節に　置き忘れた時間を　もう一度つかまえたい」と聴き手によっていくらでも解釈が分かれるようなフレーズも、聴きなじみは良くてもやってることは凄い。 Aメロからサビに行かずもう一回Aメロ繰り返す「もっかいジャブ繰り出すスタイル」の確立、フルで曲を聴いた人にだけ分かるようにあえて2番サビにとっておきのメッセージを持ってくるところ、などなど聴き所多し。誰しもラスサビ前の「成り行きまかせの恋におち～時代じゃない」のとこの早口1回は真似したでしょ?\
\
ひゃ～尖ってるぅ!鋭いロックソングだけどさりげなくアコギ鳴ってるとこがクールに感じられる。今笑顔で「なんてことの無い作業が　この世界を回り回って　何処の誰かも知らない人の笑い声を作ってゆく」なんて歌ってる人が、10年ちょっと前には「見えない敵にマシンガンをぶっ放せ　Sister\ and\ Brother」なんて歌ってたとか想像できます? )

#曲設定n
5.times do |i|
  15.times do |n|
    random = Random.new
    # k = random.rand(1..20)
    h = random.rand(0..199)
    h2 = random.rand(0..199)
    h3 = random.rand(0..4)
    if n == random.rand(1..15)
      # Track.create(list_id: i+1, artist: artists[h], song: tracks[h], description: "この曲のバースはハンパじゃない。昔から聞いてるけどバース１のパンチラインが何回聞いても癖になる！！", recommend: true, row_order: n+1)
      Track.create(list_id: i+1, artist: artists[h], song: tracks[h], description: des_str[h3], recommend: true, row_order: n+1)
    else
      Track.create(list_id: i+1, artist: artists[h], song: tracks[h], recommend: false, row_order: n+1)
    end
  end
end

