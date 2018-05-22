class UserNameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    #半角英数字、アンダーバー、コンマのみ
    if value !~ /\A^[!a-zA-Z0-9_]+$\Z/
      err_msg(record)
    elsif isonly_under_spage(value)
      err_msg(record)
    end
    
    if value !~ /^(?=.*?[a-zA-Z])/
      record.errors.add(:base, "ユーザー名は半角英字を必ず1文字以上入力してください")
    end
    
    if Constants::ERR_WORD.include?(value)
      record.errors.add(:base, "このユーザー名は使用できません")
    end
    
  end
  
  def err_msg(record)
    record.errors.add(:base, "ユーザー名に半角英数字、アンダーバー（ _ ）以外は使用できません")
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