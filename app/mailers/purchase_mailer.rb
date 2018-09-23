class PurchaseMailer < ApplicationMailer
  default from: "info@starlistz.com" #送信元アドレス

  #プレイリスト購入者へのメール
  def buyer(purchase, buyer_user)
    @purchase = purchase
    @buyer_user = buyer_user
    mail(to: buyer_user.email, subject: "プレイリストの購入が完了しました")
  end

  #プレイリスト販売者へのメール
  def seller(purchase, seller_user)
    @purchase = purchase
    @seller_user = seller_user
    mail(to: seller_user.email, subject: "プレイリストが購入されました")
  end
end
