class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:following, :follower]
  before_action :gon_current_user, only: [:show]

  def show
    @user = User.find(params[:id])
    @mylist = @user.lists.includes(:taggings)
    @following = @user.following_relationships.count
    @follower = @user.follower_relationships.count
    # @pages = @list.page(params[:page])
    @mylist_pages = @mylist.page(params[:mylist_page])

    
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
        #購入履歴
        @my_purchase = Purchase.includes({list: [:user]}).where(user_id: current_user.id).order(created_at: :desc)
        @my_purchase_pages = @my_purchase.page(params[:my_purchase_page])
      end
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
