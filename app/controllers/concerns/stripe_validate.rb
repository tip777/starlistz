module StripeValidate
  ## Stripeの情報設定の際のValidation
    
  #販売者情報Validate
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
  
  #販売事業者情報Validate
  def com_info_validate(com_info_params)
    com_errors = Array.new
    @com_info = com_info_params
    
    if @com_info[:business_name] == "" 
      com_errors.push("販売事業者の名称を入力してください")
    end
    unless @com_info[:support_email] == ""
      if @com_info[:support_email] !~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
        com_errors.push("メールアドレスの形式が不正です")
      end
    end
    unless @com_info[:support_phone] == ""
      if @com_info[:support_phone] !~ /\A^[!\d]+$\Z/
        com_errors.push("電話番号に半角数字以外が使用されています")
      end
    end

    return com_errors
  end
  
  #口座情報Validate
  def bank_info_validate(bank_info_params)
    bank_errors = Array.new
    @bank_info = bank_info_params
    
    if @bank_info[:bank_code] == "" 
      bank_errors.push("銀行コード(半角数値４桁)を入力してください")
    else
      if @bank_info[:bank_code].length != 4 || @bank_info[:bank_code] !~ /\A^[!\d]+$\Z/
        bank_errors.push("銀行コード(半角数値４桁)が不正です")
      end
    end
    
    if @bank_info[:branch_code] == "" 
      bank_errors.push("支店コード(半角数値３桁)を入力してください")
    else
      if @bank_info[:branch_code].length != 3 || @bank_info[:branch_code] !~ /\A^[!\d]+$\Z/
        bank_errors.push("支店コード(半角数値３桁)が不正です")
      end
    end
    
    if @bank_info[:account_number] == "" 
      bank_errors.push("口座番号(半角数値８桁以内)を入力してください")
    else
      if @bank_info[:account_number].length != 7 and @bank_info[:account_number].length != 8 || @bank_info[:account_number] !~ /\A^[!\d]+$\Z/
        bank_errors.push("口座番号(半角数値８桁以内)が不正です")
      end
    end
    
    if @bank_info[:owner_name] == "" 
      bank_errors.push("口座名義(全角カナ)を入力してください")
    else
      if @bank_info[:owner_name] !~ /\A^[!ァ-ン]+$\Z/
        bank_errors.push("口座名義(全角カナ)が不正です")
      end
    end
    
    return bank_errors
  end
  
end