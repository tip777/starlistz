class ChargesController < ApplicationController

  def create
    begin
      list = List.find_by(id: params[:list])

      if list.nil? 
          redirect_to :back, alert: 'プレイリストが存在しません。トップページから操作をやり直してください。'
      end
      
      if is_purchase?(current_user, list)
        list_purchase = true
        return
      end
      
      binding.pry
      
      # プレイリストの金額
      @amount = list.price
      @fee = @amount*0.1 #StarListz決済手数料：決済金額の10% 

      token = params[:stripeToken]
      
      customer = find_or_create_stripe_customer(current_user)
      customer.source = token
      customer.save
      
      token = Stripe::Token.create({
        :customer => customer.id,
      }, {:stripe_account => list.user.stripe_acct_id})

      charge = Stripe::Charge.create({
        :amount      => @amount,
        :description => 'Rails Stripe customer',
        :currency    => 'jpy',
        :source => token.id,
        :application_fee => @fee.floor
      }, :stripe_account => list.user.stripe_acct_id)

      #購入履歴
      purchase = current_user.purchases.create
      purchase.list_id = list.id
      purchase.save!
        
      # TODO add more detailed error messages
    rescue Stripe::APIConnectionError => e
      flash[:error] = 'ストライプとのネットワーク通信に失敗しました'
    rescue Stripe::APIError => e
      flash[:error] = 'ストライプとのネットワーク通信に失敗しました'
    rescue Stripe::AuthenticationError => e
      flash[:error] = "StripeのAPIによる認証に失敗しました<br/>（最近APIキーを変更した可能性があります）"
    rescue Stripe::CardError => e
      # Since it's a decline, Stripe::CardError will be caught
      body = e.json_body
      err  = body[:error]
      if err[:code] == "card_declined"
        flash[:error] = "このカードは拒否されました。"
      else
        flash[:error] = e.message
      end
      
      puts "Status is: #{e.http_status}"
      puts "Type is: #{err[:type]}"
      puts "Charge ID is: #{err[:charge]}"
      # The following fields are optional
      puts "Code is: #{err[:code]}" if err[:code]
      puts "Decline code is: #{err[:decline_code]}" if err[:decline_code]
      puts "Param is: #{err[:param]}" if err[:param]
      puts "Message is: #{err[:message]}" if err[:message]
    rescue Stripe::InvalidRequestError => e
      p e.message
      flash[:error] = '無効なパラメータがStripeのAPIに供給されました'
    rescue Stripe::StripeError => e
      p e.message
      flash[:error] = 'エラーが発生しました'
    rescue => e
      p e.message
      flash[:error] = "エラーが発生しました"
    ensure
      if list_purchase == true
        redirect_to  list_url(list), notice: "既にプレイリストは購入されています"
      elsif flash[:error].nil? 
        redirect_to  list_url(list), notice: "プレイリストを購入しました"
      else
        redirect_back(fallback_location: root_path, alart: "プレイリストの購入に失敗しました")
        flash[:notice] = 'プレイリストの購入に失敗しました'
      end
    end
  end
  
end
