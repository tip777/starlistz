class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:following, :follower]
  before_action :gon_current_user, only: [:playlist, :purchasehistory]
  before_action :show_head, only: [:playlist, :purchasehistory]

  def show_head
    @user = User.find(params[:id])
    @following = @user.following_relationships.count
    @follower = @user.follower_relationships.count
    @mylist = @user.lists
    
    if current_user != nil
      #Customer取得
      @customer = find_or_create_stripe_customer(current_user)
      if current_user.id == @user.id
        #Stripe連携しているか判定
        is_account = is_stripe_account_id?(current_user)
        if is_account != true
          flash.now[:alert] = "Stripe連携が完了していません。<br>
                            「Stripe接続」からStripe連携を完了しなければプレイリストを作成できません。".html_safe
        end
      end
    end
  end
  
  def playlist
    @mylist_pages = @mylist.includes(:taggings).page(params[:mylist_page])
  end
  
  def purchasehistory
    if current_user != nil && current_user.id == @user.id
      #購入履歴
      @my_purchase = Purchase.includes({list: [:user]}).where(user_id: current_user.id).order(created_at: :desc)
      @my_purchase_pages = @my_purchase.page(params[:my_purchase_page])
    else
      reject_page
    end
  end
  
  def salesmanage
    @user = User.find(params[:id])
    if current_user != nil && current_user.id == @user.id
      @saleslist = @user.lists
      # @all_amount = Purchase.where(list_id: @saleslist.pluck(:id))
      calc_count = Purchase.where(list_id: @saleslist.pluck(:id)).group(:list_id).count 
      @all_amount = 0
      # 全期間の合計売上額　
      calc_count.each_pair { |key, value| @all_amount = List.find(key).price * value + @all_amount }
      
      # 対象年度の毎月の売上額を計算
      if params[:year] = Time.zone.now.strftime("%-Y") && params[:year].nil? #今年かparams[:year]が空だったら
        date = Time.zone.now
        year = date.strftime("%-Y")
        month = date.strftime("%-m")
        @all_month_amount = {}
        for i in 1..month do
          month_amount = 0
          calc_count = Purchase.where(list_id: @saleslist.pluck(:id), order_date: Time.zone.local(year, i, 1).in_time_zone.all_month ).group(:list_id).count
          # 一月の合計売上額　
          calc_count.each_pair { |key, value| month_amount = List.find(key).price * value + month_amount }
          if month_amount > 0 # 売り上げがあったら
            @all_month_amount.store(i, month_amount)
          end
        end
        
      else
        year = params[:year]
        month = 12
        @all_month_amount = {}
        for i in 1..month do
          month_amount = 0
          calc_count = Purchase.where(list_id: @saleslist.pluck(:id), order_date: Time.zone.local(year, i, 1).in_time_zone.all_month ).group(:list_id).count
          # 一月の合計売上額　
          calc_count.each_pair { |key, value| month_amount = List.find(key).price * value + month_amount }
          if month_amount > 0 # 売り上げがあったら
            @all_month_amount.store(i, month_amount)
          end
        end
        
      end
      
    else
      reject_page
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

end
