class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # binding.pry
    @list = @user.lists
    @following = @user.following_relationships.count
    @follower = @user.follower_relationships.count
  end
end
