# class MultiPresenceValidator < ActiveModel::Validator
#   def validate(record)
#     record.errors.add(:base, "カスタムvalidate 成功")
#   end
# end
class RegularValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add(:base, "カスタムvalidate 成功")
  end
end
