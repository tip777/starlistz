class RegularValidator < ActiveModel::Validator
  def validate(record)
    # i18n_message_path = "activerecord.errors.models.#{record.class.name.underscore}.attributes.#{options[:column_name].to_s}.not_allow_format"

    # unless present_checker(record[options[:column_name]])
    #   record.errors[options[:column_name]] << I18n.t(i18n_message_path + '.blank')
    # end

    # unless format_checker(record[options[:column_name]])
    #   record.errors[options[:column_name]] << I18n.t(i18n_message_path + '.not_allow_format')
    # end
  end
end