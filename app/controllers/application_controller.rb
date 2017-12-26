class ApplicationController < ActionController::Base
  before_action :search_header
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  def search_header
      @q = User.ransack(params[:q])
      @search_user = @q.result(distinct: true)

      @q2 = List.search(params[:q])
      @list = @q2.result(distinct: true)
  end
  
  
  protected
 
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
