class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:following, :follower]
  before_action :gon_current_user, only: [:playlist, :purchasehistory, :favplaylist]
  before_action :show_head, only: [:playlist, :purchasehistory, :favuser, :favplaylist]
  
  include StripeValidate #Stripe Validate
  include YahooAPI 

  def show_head
    @user = User.with_deleted.find_by(id: params[:id])
    if @user.nil? || @user.paranoia_destroyed?
      reject_page

    else
      @following = @user.following_relationships.count
      @follower = @user.follower_relationships.count
      @mylist = @user.lists.includes(:user, :taggings)

      if current_user != nil
        #Customer取得
        @customer = find_or_create_stripe_customer(current_user)
      end
    end
  end

  def favuser
    if current_user != nil && current_user.id == @user.id
      following_ids = @user.following_relationships.pluck(:followed_id)
      @favuser = User.includes(:user_profile).where(id: following_ids).order("name")
      @favuser_pages = @favuser.page(params[:favuser_page])
    else
      reject_page
    end
  end

  def favplaylist
    if current_user != nil && current_user.id == @user.id
      favlist_ids = ListFavorite.where(user_id: @user.id).pluck(:list_id)
      @favlist = List.includes({user: [:user_profile]}, :taggings).where(id: favlist_ids).order("title")
      @favlist_pages = @favlist.page(params[:favlist_page])
    else
      reject_page
    end
  end

  def playlist
    @mylist_pages = @mylist.includes(:taggings).page(params[:mylist_page])
  end

  def purchasehistory
    if current_user != nil && current_user.id == @user.id
      #購入履歴
      @my_purchase = Purchase.unscope(:where).includes({list: [:user]}).where(user_id: current_user.id).order(created_at: :desc)
      @my_purchase_pages = @my_purchase.page(params[:my_purchase_page])
    else
      reject_page
    end
  end

  #売上管理
  def salesmanage
    @user = User.find(params[:id])
    if current_user != nil && current_user.id == @user.id
      @sales_list = @user.lists.with_deleted
      # 売上がある年
      @year_list = Purchase.unscope(:where).where(list_id: @sales_list.pluck(:id)).group("Year(order_date)").order('order_date DESC').pluck(:order_date)
      @year_list.each_with_index {|val, i| @year_list[i] =  val.strftime("%-Y")} #日付の形式変更

      # 全期間の合計売上額
      calc_count = Purchase.unscope(:where).where(list_id: @sales_list.pluck(:id)).group(:list_id).count
      @all_amount = 0
      calc_count.each_pair { |key, value| @all_amount = List.with_deleted.find(key).price * value + @all_amount }

      if params[:year].nil? and !@year_list.empty? #params[:year]が空だったら
        params[:year] = @year_list.first
      elsif @year_list.empty?
        return
      end

      # 対象年度の毎月の売上額を計算
      if params[:year] == Time.zone.now.strftime("%-Y") #今年だったら
        date = Time.zone.now
        @year = date.strftime("%-Y")
        month = date.strftime("%-m")
        @all_month_amount = {}
        for i in 1..month.to_i do
          i = month.to_i - (i - 1) #for 逆から回す
          month_amount = 0
          calc_count = Purchase.unscope(:where).where(list_id: @sales_list.pluck(:id), order_date: Time.zone.local(@year, i, 1).in_time_zone.all_month ).group(:list_id).count
          # 一月の合計売上額　
          calc_count.each_pair { |key, value| month_amount = List.with_deleted.find(key).price * value + month_amount }

          if month_amount > 0 # 売り上げがあったら
            @all_month_amount.store(i, month_amount)
          end
        end

      else
        @year = params[:year]
        month = 12
        @all_month_amount = {}

        for i in 1..month.to_i do
          i = month.to_i - (i - 1) #for 逆から回す
          month_amount = 0
          calc_count = Purchase.unscope(:where).where(list_id: @sales_list.pluck(:id), order_date: Time.zone.local(@year, i, 1).in_time_zone.all_month ).group(:list_id).count

          # 一月の合計売上額　
          calc_count.each_pair { |key, value| month_amount = List.with_deleted.find(key).price * value + month_amount }
          if month_amount > 0 # 売り上げがあったら
            @all_month_amount.store(i, month_amount)
          end
        end

      end

    else
      reject_page
    end
  end

  #月間売上管理
  def salesmonth
    @user = User.find(params[:id])
    if current_user != nil && current_user.id == @user.id
      @list_amount = {} #hash 初期化
      @sales_list = [] #array 初期化
      list = @user.lists.with_deleted
      @date = Time.zone.local(params[:year], params[:month], 1)
      year = @date.strftime("%-Y")
      month = @date.strftime("%-m")

      list_amount = Purchase.unscope(:where).where(list_id: list.pluck(:id), order_date: Time.zone.local(year, month, 1).in_time_zone.all_month ).group(:list_id).count

      # 対象月のプレイリスト毎の売上額
      @month_amount = 0
      list_amount.each_with_index do |(key,value),i|
        target_list = List.with_deleted.find(key)
        amount = target_list.price * value
        #削除済みリストだったら後尾に「(削除済)」と付ける
        if target_list.deleted_at.nil?
          @list_amount.store(target_list.title, amount)
        else
          @list_amount.store(target_list.title + "*", amount)
        end
        @sales_list.push(key)
        @month_amount = @month_amount + amount
      end
    else
      reject_page
    end
  end

  def payment_info
    customer = find_or_create_stripe_customer(current_user)
    unless customer.sources.data.empty?
      @credit_card = customer.sources.retrieve(customer.sources.data[0].id)
    end
  end

  def account_info
    account = find_or_create_stripe_account(current_user)
    if account == nil
      reject_page
    else
      @acc_info = account.legal_entity
      @acc_errors = Array.new
      gon.api_key = ENV['GOOGLE_API_KEY']
    end
  end

  def company_info
    @account = find_or_create_stripe_account(current_user)
    if @account == nil
      reject_page
    else
      
      @com_info = @account.legal_entity
      @com_errors = Array.new
    end
  end

  def bank_info
    account = find_or_create_stripe_account(current_user)
    if account == nil
      reject_page
    else
      @bank_info = account.external_accounts.all(:limit => 1, :object => "bank_account")
      @bank_errors = Array.new
    end
  end

  def payouthistory
  end
  
  def stripe_update
    if current_user.nil?
      reject_page
      exit!
    end
    # カード情報の変更の場合
    if stripe_params[:flg] == "card" 
      customer = find_or_create_stripe_customer(current_user)
      customer.source = card_params[:stripeToken]
      if customer.save
        redirect_to users_playlist_path(current_user), notice: "お支払い方法を更新しました"
      else
        redirect_to payment_info_path(current_user), notice: "お支払い方法の更新に失敗しました"
      end
    
    # 販売者情報の変更の場合
    elsif stripe_params[:flg] == "ac_info" 
      begin
        acc_info = acc_info_params
        @acc_errors = acc_info_validate(acc_info)
        if @acc_errors.empty?
          account = find_or_create_stripe_account(current_user)
          #氏名
          account.legal_entity.last_name_kanji = acc_info[:last_name_kanji]
          account.legal_entity.first_name_kanji = acc_info[:first_name_kanji]
          account.legal_entity.last_name_kana = put_ruby_on(acc_info[:last_name_kanji])[0]
          account.legal_entity.first_name_kana = put_ruby_on(acc_info[:first_name_kanji])[0]
          #住所
          account.legal_entity.address_kanji.postal_code  = acc_info[:postal_code]
          account.legal_entity.address_kanji.state  = acc_info[:state]
          account.legal_entity.address_kanji.city  = acc_info[:city]
          account.legal_entity.address_kanji.town  = acc_info[:town]
          account.legal_entity.address_kanji.line1  = acc_info[:line1]
          account.legal_entity.address_kana.postal_code  = acc_info[:postal_code]
          account.legal_entity.address_kana.state  = put_ruby_on(acc_info[:state])[0]
          account.legal_entity.address_kana.city  = put_ruby_on(acc_info[:city])[0]
          account.legal_entity.address_kana.town  = put_ruby_on(acc_info[:town])[0]
          account.legal_entity.address_kana.line1  = put_ruby_on(acc_info[:line1])[0]
          #電話番号
          account.legal_entity.phone_number = acc_info[:phone_number]
          #生年月日
          account.legal_entity.dob.year = acc_info[:date][:year]
          account.legal_entity.dob.month = acc_info[:date][:month]
          account.legal_entity.dob.day = acc_info[:date][:day]
          #性別
          account.legal_entity.gender = acc_info[:gender]
          #タイプ
          account.legal_entity.type = "individual"
          
          if account.save
            redirect_to users_playlist_path(current_user), notice: "販売者情報を更新しました"
          end
        else
          render 'account_info'
        end
      rescue => e
        # エラー時の処理
        flash.now[:alert] = "販売者情報の更新に失敗しました"
        render 'account_info'
      end
    
    # 販売事業者の変更の場合
    elsif stripe_params[:flg] == "com_info" 
      begin
        com_info = com_info_params
        @com_errors = com_info_validate(com_info)
        if @com_errors.empty?
          account = find_or_create_stripe_account(current_user)
          #会社名
          account.legal_entity.business_name = com_info[:business_name]
          #連絡先
          account.support_email = com_info[:support_email]
          account.support_email = com_info[:support_email]
          
          if account.save
            redirect_to users_playlist_path(current_user), notice: "販売事業者情報を更新しました"
          end
        else
          render 'company_info'
        end
      rescue => e
        # エラー時の処理
        flash.now[:alert] = "販売事業者情報の更新に失敗しました"
        render 'company_info'
      end
    
    # 口座情報の変更の場合
    elsif stripe_params[:flg] == "bank_info"
      begin
        account = find_or_create_stripe_account(current_user)
        bank_info = bank_info_params
        bank_info[:owner_name] = bank_info[:owner_name].gsub(/[\s|　]+/, '')
        @bank_errors = bank_info_validate(bank_info)
        if @bank_errors.empty? and bank_info[:errorBank].nil?
          bank_account = account.external_accounts.create(external_account: bank_info[:stripeToken])
          if bank_account.save
            redirect_to users_playlist_path(current_user), notice: "口座情報を更新しました"
          end
        else
          @bank_info = account.external_accounts.all(:limit => 1, :object => "bank_account")
          render 'bank_info'
        end
      rescue => e
        # エラー時の処理
        @bank_info = account.external_accounts.all(:limit => 1, :object => "bank_account")
        flash.now[:alert] = "口座情報の更新に失敗しました"
        render 'bank_info'
      end
      
    else
      redirect_to users_playlist_path(current_user)
    end
    
  end

  def following
    @user = User.find(params[:id])
    @following = @user.following_users
    @relationship = @user.following_relationships.count
  end

  def follower
    @user = User.find(params[:id])
    @follower = @user.follower_users
    @relationship = @user.follower_relationships.count
  end

  private
  
  def stripe_params
    params.permit(:flg)
  end
  
  def card_params
    params.permit(:stripeToken, :authenticity_token)
  end
  
  def acc_info_params
    params.permit(:authenticity_token, :last_name_kanji, :first_name_kanji, :postal_code, :state, :city, :town, :line1, :phone_number, {date: [:year, :month, :day]}, :gender)
  end
  
  def com_info_params
    params.permit(:authenticity_token, :business_name, :support_email, :support_phone)
  end
  
  def bank_info_params
    params.permit(:authenticity_token, :stripeToken, :bank_code, :branch_code, :account_number, :owner_name, :bankError)
  end

end
