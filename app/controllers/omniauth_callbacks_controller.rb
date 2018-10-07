class OmniauthCallbacksController < ApplicationController
  def twitter
    if current_user.nil?
      @user = User.from_omniauth(request.env["omniauth.auth"].except("extra"))
      if @user.persisted?
          sign_in_and_redirect @user
      else
          session["devise.user_attributes"] = @user.attributes
          redirect_to new_user_registration_url
      end

    else
      basic_action(current_user)
    end
  end

  def failure
    redirect_to root_path
  end

  private
  def basic_action(user)
    @omniauth = request.env['omniauth.auth']
    if @omniauth.present?
      @profile = SocialProfile.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
      unless @profile
        @profile = SocialProfile.where(provider: @omniauth['provider'], uid: @omniauth['uid']).new
        @profile.user = user
        @profile.save!
        flash[:notice] = "twitterを連携しました。"
      else
        unless @profile.user == current_user
          flash[:notice] = "このtwitterアカウントは他のユーザーと連携しているため連携できません。"
        end
      end
      @profile.set_values(@omniauth)
      redirect_to users_playlist_path(current_user)
    end
  end

end
