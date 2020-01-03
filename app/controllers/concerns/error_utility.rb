module ErrorUtility
  #exceptions のログ共通か
  def log_error(e, level, msg)
    if level == Constants::LOG_Fatal_LEVEL
      Rails.logger.fatal("#{level}: #{msg}")
      if e != nil
        Rails.logger.fatal e.class
        Rails.logger.fatal e.message
        Rails.logger.fatal e.backtrace.join("\n")
      end
    else
      Rails.logger.error("#{level}: #{msg}")
      if e != nil
        Rails.logger.error e.class
        Rails.logger.error e.message
        Rails.logger.error e.backtrace.join("\n")
      end
    end
  end
  
  def log_supportContact(contact, user)
    Rails.logger.info("Info: StarListz_SupportContact")
    if user != nil
      Rails.logger.info("SupportContact_user_id: #{user.id} | user_name: #{user.name}")
    end
    Rails.logger.info("SupportContact__name: #{contact.name}")
    Rails.logger.info("SupportContact__email: #{contact.email}")
    Rails.logger.info("SupportContact__title: #{contact.title}")
    Rails.logger.info("SupportContact__message: #{contact.message}")
  end
  
  def log_unsubscribe(contact, user)
    Rails.logger.info("Info: StarListz_Unsubscribe")
    if user != nil
      Rails.logger.info("Unsubscribe_user_id: #{user.id} | user_name: #{user.name}")
    end
    Rails.logger.info("Unsubscribe_contact_message: #{contact.message}")
  end

  # プレイリストが購入されたログ
  def log_purchasedList(purchase_uid)
    Rails.logger.info("ListPurchased || PurchaseUid: #{purchase_uid}")
  end

end