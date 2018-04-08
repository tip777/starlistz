class UsersController < ApplicationController
  # before_action :authenticate_user!, only[:following, :follower]
  before_action :gon_current_user, only: [:show]
  def show
    @user = User.find(params[:id])
    @list = @user.lists
    @following = @user.following_relationships.count
    @follower = @user.follower_relationships.count
    @pages = @list.page(params[:page])
  end

  def following
    @user = User.find(params[:id])
    @following = @user.following_users
    @relationship = @user.following_relationships.count
  end

  def follower
    @user = User.find(params[:id])
    @follower = @user.follower_users
    @relationship = @user.follower_relationships.count
  end

end
