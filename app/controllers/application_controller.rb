class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :search_header
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action  :store_location
  helper_method :is_purchase?, :is_stripe_account_id?
  
  def set_user_genre
    #Userのタグだけ抽出
    return ActsAsTaggableOn::Tagging.where(taggable_type: "User").group("tag_id").pluck(:tag_id)
  end
  
  # 〇文字以上は...で表示する
  def trun_str(str, strLen)
      return str.truncate(strLen)
  end
  
  #プレイリストの購入履歴があるか
  def is_purchase?(user, list)
    if user.nil?
      return false
    else
      !user.purchases.where(list_id: list.id).empty?
    end
  end
  
  #ログインしているか判定
  def gon_current_user
    gon.current_user = current_user
  end
  
  def reject_page
    begin
      redirect_back(fallback_location: root_path)
    rescue ActionController::RedirectBackError
      redirect_to root_path
    end
  end
  
  def store_location
      if (request.fullpath != "/users/sign_in" &&
          request.fullpath != "/users/sign_up" &&
          request.fullpath !~ Regexp.new("\\A/users/password.*\\z") &&
          !request.xhr?) # don't store ajax calls
        session[:previous_url] = request.fullpath
      end
  end

  #ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    if (session[:previous_url] == root_path)
      super
    else
      session[:previous_url] || root_path
    end
  end

  #ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource)
    root_path
  end

  def search_header
    if params[:q] != nil and params[:q] != ""
      @search_word = search_params[:q]
      key_words = search_params[:q].split(/[\p{blank}\s]+/)#スペースがあったら区切る
      @q = User.includes(:user_profile, :taggings).ransack(name_cont_any: key_words)

      #ユーザー、プレイリスト検索結果
      @search_user = @q.result(distinct: true)
      @search_list = List.includes({user: [:user_profile]}, :taggings).ransack(title_cont_any: key_words).result(distinct: true)

      #ジャンル検索結果
      list_taggings = set_list_genre
      user_taggings = set_user_genre
      @search_usergenre = ActsAsTaggableOn::Tag.where(id: user_taggings).ransack(name_cont_any: key_words).result(distinct: true)
      @search_listgenre = ActsAsTaggableOn::Tag.where(id: list_taggings).ransack(name_cont_any: key_words).result(distinct: true)

      @user_pages = @search_user.page(params[:user_page])
      @list_pages = @search_list.page(params[:list_page])
      @genreuser_pages = @search_usergenre.page(params[:genreuser_page])
      @genrelist_pages = @search_listgenre.page(params[:genrelist_page])

      # @flg = false
      respond_to do |format|
        format.html
        format.js
      end
    else
      @q = User.search
    end
  end

  def set_list_genre
    #Listのタグだけ抽出
    return ActsAsTaggableOn::Tagging.where(taggable_type: "List").group("tag_id").pluck(:tag_id)
  end

  #アカウント情報取得
  def set_stripe_id(stripe_code)
      #Stripeからデータ取得
      stripe_data = get_stripe_data(stripe_code)

      #stripe_user_idを登録
      current_user.update_attributes!(stripe_acct_id: stripe_data["stripe_user_id"])
      #Cutomerデータ登録
      find_or_create_stripe_customer(current_user)
  end

  #Account登録しているか判定
  def is_stripe_account_id?(user)
    begin
      if user.stripe_acct_id.blank?
        return false
      else
        Stripe::Account.retrieve(user.stripe_acct_id.to_s)
        return true
      end
    rescue => e
      return false
    end
  end

  #Account保存
  def save_stripe_account_id(user, stripe_customer)
    User.where('id = ?', user.id).first.update_attributes!(stripe_cus_id: stripe_customer.id)
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

  def get_stripe_data(stripe_code)
    require 'net/http'
    require 'uri'

    uri = URI.parse("https://connect.stripe.com/oauth/token")
    request = Net::HTTP::Post.new(uri)
    request.set_form_data(
      "client_secret" => "sk_test_cqhiyTcvoKhdGDSMYa7YY3Kr",
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

  private

  def search_params
    params.permit(:q)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name]) #アカウント登録時にnameカラムも登録
    #user edit ジャンルのselectbox用
    devise_parameter_sanitizer.permit(:account_update,
           keys: [:tag_list, :user_profiles => [:id,:user_id, :description, :insta_url, :tw_url, :avatar]]) #userモデル編集時にプロフィールも編集
  end
end
