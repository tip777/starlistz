module StripeCreate
  ## StripeのAccount & Costomerの作成部分
  
  #Stripe 認証ページのURLを編集
  def stripe_url_edit(current_user)
    stripe_url = Constants::STRIPE_AUTH_URL + "&stripe_user[email]=#{current_user.email}" + "&stripe_user[url]=#{Constants::HP_URL}" + "&stripe_user[country]=JP" + "&stripe_user[business_name]=StarListz"  + "&stripe_user[business_type]=sole_prop" # + "&stripe_user[product_description]=StarListzを使用しているすべてのユーザーに対しプレイリストの販売を行うことができます。購入時に即座に決済が行われます。"　
  end
  
  #アカウント情報取得
  def set_stripe_id(current_user, stripe_code)
  	#Stripeからデータ取得
  	stripe_data = get_stripe_data(stripe_code)
  	#stripe_user_idを登録
  	current_user.update_attributes!(stripe_acct_id: stripe_data["stripe_user_id"])
  	#Cutomerデータ登録
  	find_or_create_stripe_customer(current_user)
  end
  
  # Stripe認証
  def get_stripe_data(stripe_code)
    require 'net/http'
    require 'uri'
  
    uri = URI.parse("https://connect.stripe.com/oauth/token")
    request = Net::HTTP::Post.new(uri)
    request.set_form_data(
      "client_secret" => STRIPE_PUBLIC_KEY,
      "code" => stripe_code,
      "grant_type" => "authorization_code",
    )
  
    req_options = {
      use_ssl: uri.scheme == "https",
    }
  
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    result = ActiveSupport::JSON.decode(response.body)
    return result
  end

  #Account保存
  def save_stripe_account_id(user, stripe_account)
    User.where('id = ?', user.id).first.update_attributes!(stripe_acct_id: stripe_account.id)
  end

  #Account取得
  def get_stripe_account_id(user)
    Stripe::Account.retrieve(user.stripe_acct_id.to_s)
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
      end

      save_stripe_customer_id(user, customer)
      return customer
    end
  end

end
