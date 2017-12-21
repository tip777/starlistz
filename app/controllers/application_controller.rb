class ApplicationController < ActionController::Base
  before_action :search_header
  protect_from_forgery with: :exception

  def search_header
      @q = User.ransack(params[:q])
      @search_user = @q.result(distinct: true)

      @q2 = List.search(params[:q])
      @list = @q2.result(distinct: true)
  end
end
