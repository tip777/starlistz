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
      Rails.logger.info("user_id: #{user.id} | user_name: #{user.name}")
    end
    Rails.logger.info("contact_name: #{contact.name}")
    Rails.logger.info("contact_email: #{contact.email}")
    Rails.logger.info("contact_title: #{contact.title}")
    Rails.logger.info("contact_message: #{contact.message}")
  end
  
  def log_unsubscribe(contact, user)
    Rails.logger.info("Info: StarListz_Unsubscribe")
    if user != nil
      Rails.logger.info("user_id: #{user.id} | user_name: #{user.name}")
    end
    Rails.logger.info("contact_message: #{contact.message}")
  end

end