class SearchesController < ApplicationController
  before_action :gon_current_user, only: [:playlist, :user]
  
  def all_result
  end
  
  def playlist
  end

  def user
  end

end