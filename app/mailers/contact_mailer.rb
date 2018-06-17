class ContactMailer < ApplicationMailer
    default from: "ttttt.iiiii.bbbbb@gmail.com" #送信元アドレス
    default to: "info@starlistz.com" #送信先アドレス

    def received_email(contact, current_user)
        @contact = contact
        @current_user = current_user
        mail(subject: @contact.title)
    end
end
