class ChargesController < ApplicationController

    def create
      # Amount in cents
      @amount = 500
      @fee = @amount*0.2-@amount*0.036 #決済金額の20%からStripe決済手数料3.6%を引いた分を手数料とする
      list = List.find_by(id: params[:list])
      
      if list.nil? 
          redirect_to :back, alert: 'プレイリストが存在しません。トップページから操作をやり直してください。'
      end

      token = params[:stripeToken]

      customer = find_or_create_stripe_customer(current_user)
      customer.source = token
      customer.save

      token = Stripe::Token.create({
        :customer => customer.id,
      }, {:stripe_account => "acct_1C7ARIC6dAi2stvc"})

      charge = Stripe::Charge.create({
        :amount      => @amount,
        :description => 'Rails Stripe customer',
        :currency    => 'jpy',
        :source => token.id,
        :application_fee => @fee.round
      }, :stripe_account => "acct_1C7ARIC6dAi2stvc")


      #購入履歴
      purchase = current_user.purchases.create
      purchase.list_id = list.id
      purchase.save

      redirect_to :back, notice: "プレイリストを購入しました"

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end

end
