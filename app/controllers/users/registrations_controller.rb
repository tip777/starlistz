class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
    if resource.save
        profile = UserProfile.new
        profile.save
        signup_user = User.find(resource.id)
        signup_user.user_profile = profile
        signup_user.save
    end
  end

  # GET /resource/edit
  def edit
    super
    # @list = current_user.lists.find
  end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
    devise_parameter_sanitizer.permit(:sign_up) do |params|
      params.permit(:email, :password, :password_confirmation, :current_password, :name)
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    # devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    devise_parameter_sanitizer.permit(:account_update) do |params|
      params.permit(:email, :password, :password_confirmation, :current_password, :name,
                    user_profiles: [:id, :description, :insta_url, :tw_url ])
    end
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    new_confirmation_path(resource)
    # super(resource)
  end
end
