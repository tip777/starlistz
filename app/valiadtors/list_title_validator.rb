class ListTitleValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    #数字以外のものは必ず1文字は含む
    if value !~ /^(?=.*?[a-zA-Z一-龠々ぁ-んァ-ンｧ-ﾝ])/
      record.errors.add(:base, "半角英字等を必ず1文字以上入力してください")
    end
    
    if value != nil
      # binding.pry
      if value.gsub(/[\s|　]+/, '').start_with?(".") || value.gsub(/[\s|　]+/, '').end_with?(".")
        record.errors.add(:base, "最初と最後にピリオド（.）は使用できません")
      end
    end
    
    if Constants::ERR_WORD.include?(value)
      record.errors.add(:base, "このプレイリスト名は使用できません")
    end

  end
end
