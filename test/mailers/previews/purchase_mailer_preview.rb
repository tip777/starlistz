# Preview all emails at http://localhost:3000/rails/mailers/purchase_mailer
class PurchaseMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/purchase_mailer/buyer
  def buyer
    PurchaseMailer.buyer
  end

  # Preview this email at http://localhost:3000/rails/mailers/purchase_mailer/seller
  def seller
    PurchaseMailer.seller
  end

end
