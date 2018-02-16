# class MultiPresenceValidator < ActiveModel::Validator
#   def validate(record)
#     record.errors.add(:base, "カスタムvalidate 成功")
#   end
# end
class RegularValidator < ActiveModel::Validator
  def validate(record)
    #半角英数字、アンダーバー、コンマのみ
    # unless record[options[:column_name]] =~ /\A^[!a-zA-Z0-9_.]+$\Z/
    #   record.errors.add(:base, "半角英数字、アンダーバー（_）、コンマ（.）以外は使用できません")
    # end
    # #動かない
    # if record[options[:column_name]] =~ /\A^[.]+$|^\Z^[.]+$/
    #   record.errors.add(:base, "最初と最後の文字にコンマ（.）は使用できません")
    # end
  end
end
