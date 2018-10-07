require 'test_helper'

class PurchaseMailerTest < ActionMailer::TestCase
  test "buyer" do
    mail = PurchaseMailer.buyer
    assert_equal "Buyer", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "seller" do
    mail = PurchaseMailer.seller
    assert_equal "Seller", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
