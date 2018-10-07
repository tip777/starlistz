class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(relation_params[:followed_id])
    current_user.follow(@user)
  end

  def destroy
    @user = current_user.following_relationships.find(relation_params[:id]).followed
    current_user.unfollow(@user)
  end
  
  private
  
  def relation_params
    params.permit(:id, :followed_id)
  end
  
end
