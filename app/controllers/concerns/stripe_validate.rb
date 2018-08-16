module StripeValidate
  ## Stripeの情報設定の際のValidation
    
  #販売車情報Validate
  def acc_info_validate(ac_info_params)
    ac_errors = Array.new
    @acc_info = ac_info_params
    if @acc_info[:last_name_kanji] !~ /\A^[!一-龠々]+$\Z/ || @acc_info[:first_name_kanji] !~ /\A^[!一-龠々]+$\Z/
      ac_errors.push("氏名に不正な文字が使用されています")
    end
    if @acc_info[:postal_code] !~ /\A^[!\d]+$\Z/
      ac_errors.push("郵便番号に半角数字以外が使用されています")
    end
    if @acc_info[:state] !~ /\A^[!一-龠々]+$\Z/
      ac_errors.push("都道府県に不正な文字が使用されています")
    end
    if @acc_info[:phone_number] !~ /\A^[!\d]+$\Z/
      ac_errors.push("電話番号に半角数字以外が使用されています")
    end
    
    return ac_errors
  end
  
end