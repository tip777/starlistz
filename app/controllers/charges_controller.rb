class ChargesController < ApplicationController
  
  def create
    begin
      list = List.is_status.find_by(id: params[:list])

      if list.nil?
          redirect_to :back, alert: 'プレイリストが存在しません。トップページから操作をやり直してください。'
      end
      
      # ここstatus: "succeed"のものしか抽出しないが大丈夫か
      if is_purchase?(current_user, list)
        list_purchase = true
        return
      end
      
      # プレイリストの金額
      @amount = list.price
      # @fee = @amount*0.1 #StarListz決済手数料：決済金額の10%　ベータ版では手数料は取らない

      token = params[:stripeToken]

      customer = find_or_create_stripe_customer(current_user)
      customer.source = token
      customer.save

      token = Stripe::Token.create({
        :customer => customer.id,
      }, {:stripe_account => list.user.stripe_acct_id})
      
      
      if current_user.purchases.where(user_id: current_user.id, list_id: list.id).empty?
        #データベースに購入履歴を記録
        purchase = current_user.purchases.create(list_id: list.id, order_date: Time.now, uid: SecureRandom.uuid)
        
        purchase.save!
        
        # 購入履歴のステータスを保留中に変更
        purchase.update!(status: "pending")
        
      else #　購入が失敗もしくは保留中の購入履歴があったら
        purchase = current_user.purchases.where(user_id: current_user.id, list_id: list.id).first
        
      end
      
      # わざとpendingにするテストコード
      # raise
      
      # Stripeで決済処理
      charge = Stripe::Charge.create({
        :amount      => @amount,
        :description => "StarListzからプレイリストが購入されました。プレイリスト名：#{list.title}",
        :currency    => 'jpy',
        :source => token.id,
        :statement_descriptor => "StarListz",
        # :application_fee => @fee.floor
      }, :stripe_account => list.user.stripe_acct_id)
      
      # 購入履歴のステータスを成功に変更
      purchase.update!(stripe_charge_id: charge.id, status: "succeeded")
      
      #購入者、販売者にメールを送る
      PurchaseMailer.buyer(purchase, current_user).deliver
      if list.user.mail_notice.list_sold == true
        PurchaseMailer.seller(purchase, list.user).deliver
      end

      # TODO add more detailed error messages
    rescue Stripe::APIConnectionError => e
      log_error(e, Constants::LOG_ERROR_LEVEL, "ChargesController : Stripe::APIConnectionError")
      flash[:error] = 'ストライプとのネットワーク通信に失敗しました'
    rescue Stripe::APIError => e
      log_error(e, Constants::LOG_ERROR_LEVEL, "ChargesController : Stripe::APIError")
      flash[:error] = 'ストライプとのネットワーク通信に失敗しました'
    rescue Stripe::AuthenticationError => e
      log_error(e, Constants::LOG_ERROR_LEVEL, "ChargesController : Stripe::AuthenticationError")
      flash[:error] = "StripeのAPIによる認証に失敗しました<br/>（最近APIキーを変更した可能性があります）"
    rescue Stripe::CardError => e
      log_error(e, Constants::LOG_ERROR_LEVEL, "ChargesController : Stripe::CardError")
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
      log_error(e, Constants::LOG_ERROR_LEVEL, "ChargesController : Stripe::InvalidRequestError")
      flash[:error] = '無効なパラメータがStripeのAPIに供給されました'
    rescue Stripe::StripeError => e
      log_error(e, Constants::LOG_ERROR_LEVEL, "ChargesController : Stripe::StripeError")
      flash[:error] = 'エラーが発生しました'
    rescue StandardError => e
      log_error(e, Constants::LOG_ERROR_LEVEL, "ChargesController : StandardError")
      flash[:error] = "エラーが発生しました"
    ensure
      if list_purchase == true
        redirect_to  list_url(list), notice: "既にプレイリストは購入されています"
      elsif flash[:error].nil?
        redirect_to  list_url(list), notice: "プレイリストを購入しました"
      else
        redirect_back(fallback_location: root_path, alart: "プレイリストの購入に失敗しました")
        flash[:alert] = 'プレイリストの購入に失敗しました'
      end
    end
  end

end
