module StripeValidate
  ## Stripeの情報設定の際のValidation
    
  #販売車情報Validate
  def acc_info_validate(ac_info_params)
    ac_errors = Array.new
    @acc_info = ac_info_params
    if @acc_info[:last_name_kanji] == "" || @acc_info[:first_name_kanji] == ""
      ac_errors.push("氏名を入力してください")
    end
    if @acc_info[:postal_code] == ""
      ac_errors.push("郵便番号を入力してください")
    else
      #入力形式チェック
      if @acc_info[:postal_code] !~ /\A^[!\d]+$\Z/
        ac_errors.push("郵便番号に半角数字以外が使用されています")
      end
    end
    if @acc_info[:state] == ""
      ac_errors.push("都道府県を入力してください")
    end
    if @acc_info[:city] == ""
      ac_errors.push("市区郡を入力してください")
    end
    if @acc_info[:town] == ""
      ac_errors.push("町村名・丁目・字を入力してください")
    end
    if @acc_info[:line1] == ""
      ac_errors.push("番地・建物名を入力してください")
    end
    if @acc_info[:phone_number] == ""
      ac_errors.push("電話番号を入力してください")
    else
      #入力形式チェック
      if @acc_info[:phone_number] !~ /\A^[!\d]+$\Z/
        ac_errors.push("電話番号に半角数字以外が使用されています")
      end
    end
    
    
    
    
    return ac_errors
    
  end
  
end