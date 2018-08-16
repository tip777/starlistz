module YahooAPI
  #Yahooルビ振りAPI
  require "open-uri"
  require "nokogiri"
   
  YAHOO_API_ID = "dj00aiZpPUlBdzBTM24wVnpuZyZzPWNvbnN1bWVyc2VjcmV0Jng9N2Q-"
   
  def put_ruby_on(word)
    return "" if word.size >= 1000
    word = word.tr("ァ-ン","ぁ-ん")
    enc_word = URI.encode(word)
    url = "http://jlp.yahooapis.jp/FuriganaService/V1/furigana?appid=#{YAHOO_API_ID}&sentence=#{enc_word}"
    doc = Nokogiri::HTML(open(url))
    
    hiragana = doc.xpath('//word/furigana').map{|i| i.text}.join rescue nil
    
    if hiragana == ""
      hiragana = word
    end
    
    return [ hiragana ]
  end
  
end