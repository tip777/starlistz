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


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name]) #アカウント登録時にnameカラムも登録
    devise_parameter_sanitizer.permit(:account_update,
           keys: [:user_profiles => [:id,:user_id, :description, :insta_url, :tw_url]]) #userモデル編集時にプロフィールも編集
  end
end
