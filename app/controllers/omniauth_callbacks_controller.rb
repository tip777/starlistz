class OmniauthCallbacksController < ApplicationController
  def twitter
    # binding.pry
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
      end
      # if current_user
      #   raise "user is not identical" if current_user != @profile.user
      # else
      #   sign_in(:user, @profile.user)
      # end
      @profile.set_values(@omniauth)
      redirect_to users_playlist_path(current_user)
    end
  end

end
