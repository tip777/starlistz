module StripeCreate
    ## StripeのAccount & Costomerの作成部分
    
  #Account保存
  def save_stripe_account_id(user, stripe_account)
    User.where('id = ?', user.id).first.update_attributes!(stripe_acct_id: stripe_account.id)
  end

  #Account取得
  def get_stripe_account_id(user)
    Stripe::Account.retrieve(user.stripe_acct_id.to_s)
  end
  
  def find_or_create_stripe_account(user)
    if user.nil?
      account = nil
    else
      if user.stripe_acct_id.blank?
        account = Stripe::Account.create(
          :type => 'custom',
          :country => 'JP'
        )
      else
        account = get_stripe_account_id(user)
      end

      save_stripe_account_id(user, account)
      return account
    end
  end
  
  
  
  #Customer保存
  def save_stripe_customer_id(user, stripe_customer)
    User.where('id = ?', user.id).first.update_attributes!(stripe_cus_id: stripe_customer.id)
  end

  #Customer検索
  def get_stripe_customer_id(user)
    Stripe::Customer.retrieve(user.stripe_cus_id.to_s)
  end

  def find_or_create_stripe_customer(user)
    if user.nil?
      cutomer = nil
    else
      if user.stripe_cus_id.blank?
        customer = Stripe::Customer.create(
            :description => "user_id: #{user.id.to_s}",
            :email => user.email.to_s
        )
      else
        customer = get_stripe_customer_id(user)
        customer.email = current_user.email
      end

      save_stripe_customer_id(user, customer)
      return customer
    end
  end
  
end