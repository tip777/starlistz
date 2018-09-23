class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :search_header
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action  :store_location
  helper_method :is_purchase?, :is_stripe_account_id?

  include StripeCreate #Stripe 作成部分

  http_basic_authenticate_with :name => "starlistz", :password => "testtest" if Rails.env.test? #heroku development Basic認証
  http_basic_authenticate_with :name => "starlistz", :password => "testtest" if Rails.env.staging? #heroku staging Basic認証
  if ENV['BASIC_AUTH_PASSWORD'] != nil
    http_basic_authenticate_with :name => "starlistz", :password => "testtest" if Rails.env.production? #本番開始　するときに消す
  end

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
      !user.purchases.where(list_id: list.id, status: "succeeded").empty?
    end
  end

  #ログインしているか判定
  def gon_current_user
    gon.current_user = current_user
  end

  def reject_page
    begin
      redirect_back(fallback_location: root_path)
    rescue ActionController::RedirectBackError => e
      logger.error(e.message)
      redirect_to root_path
    end
  end

  def store_location
      if (request.fullpath != "/users/sign_in" &&
          request.fullpath != "/users/sign_up" &&
          request.fullpath != "/users" &&
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
    begin
      if params[:q] != nil and params[:q] != ""
        @search_word = search_params[:q]
        key_words = search_params[:q].split(/[\p{blank}\s]+/)#スペースがあったら区切る
        @q = User.includes(:user_profile).ransack(name_cont_any: key_words)
  
        #ユーザー、プレイリスト検索結果
        @search_user = @q.result(distinct: true)
        @search_list = List.is_status.includes({user: [:user_profile]}, :taggings).ransack(title_cont_any: key_words).result(distinct: true)
  
        #ジャンル検索結果
        list_taggings = set_list_genre
        user_taggings = set_user_genre
        @search_usergenre = ActsAsTaggableOn::Tag.where(id: user_taggings).ransack(name_cont_any: key_words).result(distinct: true).order("taggings_count DESC")
        @search_listgenre = ActsAsTaggableOn::Tag.where(id: list_taggings).ransack(name_cont_any: key_words).result(distinct: true).order("taggings_count DESC")
  
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
    rescue StandardError => e
      logger.error(e.message)
      @q = User.search
    end
  end

  def set_list_genre
    #Listのタグだけ抽出
    return ActsAsTaggableOn::Tagging.where(taggable_type: "List").group("tag_id").pluck(:tag_id)
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
    rescue StandardError => e
      logger.error(e.message)
      return false
    end
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
