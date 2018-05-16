class SearchesController < ApplicationController
  before_action :gon_current_user, only: [:playlist, :user, :playlist_genre, :user_genre]
  def playlist
  end

  def user
  end

  def playlist_genre
  end

  def user_genre
  end
end