class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :search_header
  before_action :configure_permitted_parameters, if: :devise_controller?

  def search_header
      @q = User.ransack(params[:q])
      @search_user = @q.result(distinct: true)

      @q2 = List.search(params[:q])
      @list = @q2.result(distinct: true)
  end

  def set_list_genre
    mainno = ActsAsTaggableOn::Tag.where(taggings_count: 0)
    otherno = ActsAsTaggableOn::Tagging.where(context: "othergenres").pluck(:tag_id)
    @tag = Hash.new{|h,k| h[k] = {} }
    @tag["メインジャンル"] = ActsAsTaggableOn::Tag.where(id: mainno).pluck(:name)
    @tag["その他"] = ActsAsTaggableOn::Tag.where(id: otherno).pluck(:name)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name]) #アカウント登録時にnameカラムも登録
    # devise_parameter_sanitizer.permit(:account_update,
    #       keys: [:usergenre_list, :user_profiles => [:id,:user_id, :description, :insta_url, :tw_url, :avatar]]) #userモデル編集時にプロフィールも編集
    #user edit ジャンルのselectbox用
    devise_parameter_sanitizer.permit(:account_update,
           keys: [usergenre_list: [], :user_profiles => [:id,:user_id, :description, :insta_url, :tw_url, :avatar]]) #userモデル編集時にプロフィールも編集
  end
end
