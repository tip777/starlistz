class ContactMailer < ApplicationMailer
    default from: "contact@starlistz.mail" #送信元アドレス
    default to: "ttttt.iiiii.ppppp@gmail.com" #送信先アドレス

    def received_email(contact)
        @contact = contact
        mail(subject: 'お問い合わせを承りました')
    end
end
