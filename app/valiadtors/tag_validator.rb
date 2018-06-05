class TagValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    value.each do |val|
        if val !~ /\A^[!a-zA-Z0-9一-龠々ぁ-んァ-ンー－ｧ-ﾝﾞﾟ_]+$\Z/
          err_msg(record)
        elsif isonly_under_spage(val)
          err_msg(record)
        end
        
        #99文字以上だったら
        if val.length > 99
          record.errors.add(:base, 'ジャンルは99文字以内です')
        end
    end
  end
  
  def err_msg(record)
    record.errors.add(:base, 'ジャンルに使用可能文字以外が含まれています')
  end
  
  # アンダーバー、全角&半角スペースだけか判定
  def isonly_under_spage(str)
    n = 0
    str = str.split("_")
    ch_cnt = str.count
    
    str.each_with_index do |val, i|
      if val.gsub(/[\s|　]+/, '') == ""
        n = n + 1
      end
    end 
    
    if ch_cnt == n then
      return true
    end
    
    return false
  end
end