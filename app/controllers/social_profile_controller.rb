class SocialProfileController < ApplicationController
    def destroy
        redirect_to root_path if current_user.nil?
        begin
            current_user.social_profiles.destroy_all
            flash[:notice] = "twitter 連携を解除しました。"
        rescue StandardError => e
            logger.error(e.message)
            flash[:alert] = "twitter 連携を解除できませんでした。"
        end
        redirect_to users_playlist_path(current_user)
    end
end
