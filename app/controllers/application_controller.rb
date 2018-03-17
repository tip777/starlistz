class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :search_header
  before_action :configure_permitted_parameters, if: :devise_controller?

  def search_header
      if params[:q] != nil and params[:q] != ""
        key_words = search_params[:q].split(/[\p{blank}\s]+/)#スペースがあったら区切る
        @q = User.ransack(name_cont_any: key_words)
        @search_user = @q.result(distinct: true)
        @search_list = List.ransack(title_cont_any: key_words).result(distinct: true)

        @user_pages = @search_user.page(params[:user_page])
        @list_pages = @search_list.page(params[:list_page])

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
