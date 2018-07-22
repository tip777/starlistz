class OmniauthCallbacksController < ApplicationController
  def twitter
      # binding.pry
      @user = User.from_omniauth(request.env["omniauth.auth"].except("extra"))

      if @user.persisted?
          sign_in_and_redirect @user
      else
          session["devise.user_attributes"] = @user.attributes
          redirect_to new_user_registration_url
      end
  end
  
  def failure
    redirect_to root_path
  end
end
