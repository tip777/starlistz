class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :search_header
  before_action :configure_permitted_parameters, if: :devise_controller?

  def search_header
      if params[:q] != nil and params[:q] != ""
        @search_word = search_params[:q]
        key_words = search_params[:q].split(/[\p{blank}\s]+/)#スペースがあったら区切る
        @q = User.ransack(name_cont_any: key_words)
        
        #ユーザー、プレイリスト検索結果
        @search_user = @q.result(distinct: true)
        @search_list = List.ransack(title_cont_any: key_words).result(distinct: true)
        
        #ジャンル検索結果
        list_taggings = set_list_genre
        user_taggings = set_user_genre
        @search_usergenre = ActsAsTaggableOn::Tag.where(id: user_taggings).ransack(name_cont_any: key_words).result(distinct: true)
        @search_listgenre = ActsAsTaggableOn::Tag.where(id: list_taggings).ransack(name_cont_any: key_words).result(distinct: true)
        
        # binding.pry
        
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
  
  def set_user_genre
    #Userのタグだけ抽出
    return ActsAsTaggableOn::Tagging.where(taggable_type: "User").group("tag_id").pluck(:tag_id)
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
