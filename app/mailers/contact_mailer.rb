class ContactMailer < ApplicationMailer
#   def contact_email(inquiry)
#     @contact = contact
#     mail to: contact.email, subject: "お問い合わせありがとうございます", bcc: "sample@example.com"
#   end
    default from: "example@gmail.com"
    default to: "ttttt.iiiii.ppppp@gmail.com"
     
    def received_email(contact)
        @contact = contact
        mail(:subject => 'お問い合わせを承りました')
    end
end