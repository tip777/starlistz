class SocialProfileController < ApplicationController
    def destroy
        redirect_to root_path if current_user.nil?
        current_user.social_profiles.destroy_all
        flash[:notice] = "twitter 連携を解除しました。"
        redirect_to users_playlist_path(current_user)
    end
end
