class UserNameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    半角英数字、アンダーバー、コンマのみ
    unless record[options[:column_name]] =~ /\A^[!a-zA-Z0-9_.]+$\Z/
      record.errors.add(:base, "半角英数字、アンダーバー（_）、コンマ（.）以外は使用できません")
    end
    #動かない
    if record[options[:column_name]] =~ /\A^[.]+$|^\Z^[.]+$/
      record.errors.add(:base, "最初と最後の文字にコンマ（.）は使用できません")
    end
  end
  
  def err_msg(record)
    record.errors.add(:base, 'このユーザー名は使用できません')
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