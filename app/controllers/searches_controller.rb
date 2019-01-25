class SearchesController < ApplicationController
  before_action :gon_current_user, only: [:playlist, :user, :playlist_genre, :user_genre]
  
  def all_result
  end
  
  def playlist
  end

  def user
  end

end