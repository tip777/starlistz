class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:following, :follower]
  before_action :gon_current_user, only: [:playlist, :purchasehistory, :favplaylist]
  before_action :show_head, only: [:playlist, :purchasehistory, :favuser, :favplaylist]

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

  end

  def account_info
  end

  def business_info
  end

  def bank_info
  end

  def payouthistory
  end

  def stripe_update
    binding.pry
    card_params
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
      def card_params
        params.permit(:amount, :stripeToken, :name, :authenticity_token)
      end

end
