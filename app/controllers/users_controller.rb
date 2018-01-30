class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @list = @user.lists
    @following = @user.following_relationships.count
    @follower = @user.follower_relationships.count
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
