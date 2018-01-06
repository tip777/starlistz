class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  #メール認証したらそのままログイン
  def show
    super do |resource|
      sign_in(resource)
    end
    # super do |resource|
    #   if user_signed_in?#ログインしていたら
    #     binding.pry
    #     if current_user.email == resource.email
    #       binding.pry
    #       edit_user_registration_path(resource)
    #     else
    #       sign_in(resource)
    #     end
    #   else
    #     sign_in(resource)
    #   end
    # end
  end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
