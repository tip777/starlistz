class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
  end

  def destroy
    @user = current_user.following_relationships.find(params[:id]).followed
    current_user.unfollow(@user)
  end
  
  # Private
  
  # def relation_params
  #   params.require(:user)
  #   params.require(:post).permit(:title)
  # end
  
end
