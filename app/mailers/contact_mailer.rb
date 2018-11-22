class ContactMailer < ApplicationMailer
    default from: "info@starlistz.com" #送信元アドレス
    default to: "support@starlistz.com" #送信先アドレス

    def received_email(contact, current_user)
        @contact = contact
        @current_user = current_user
        mail(subject: @contact.title)
    end
    
    # def unsub_email(contact, current_user)
    #     @contact = contact
    #     @current_user = current_user
    #     mail(subject: "ユーザーが退会")
    # end
end
