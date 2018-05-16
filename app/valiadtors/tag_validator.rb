class TagValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    value.each do |val|
        # unless val =~ /\A^[!a-zA-Z0-9一-龠々_]+$\Z/
        unless val =~ /\A^[!a-zA-Z0-9一-龠々ぁ-んァ-ンー－ｧ-ﾝﾞﾟ_]+$\Z/
            record.errors.add(:base, 'ジャンルに使用可能文字以外が含まれています')
        end
    end
  end
end