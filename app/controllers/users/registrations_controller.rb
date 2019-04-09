class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  include StripeCreate #Stripe 作成部分

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
    if resource.save
        signup_user = User.find(resource.id)
        signup_user.create_user_profile #user_profile 作成
        #規約への同意フラグ、同意日時を保存
        signup_user.tos_acceptance = true
        signup_user.tos_acceptance_date = Time.now
        signup_user.save
    end
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  #アカウント削除時
  def destroy
    customer = find_or_create_stripe_customer(current_user)
    #Customer削除
    if customer != nil
      customer.delete
    end

    resource.destroy

    #削除したユーザーのemail,nameを変更（重複対策）
    delete_user = User.with_deleted.find(resource.id)
    change_email = resource.deleted_at.to_i.to_s + '_' + resource.email.to_s
    resource.email = change_email
    resource.unconfirmed_email = nil
    resource.skip_reconfirmation!
    resource.attributes = {name: "*" + resource.name.to_s}
    resource.save!(validate: false)

    #退会理由をつけたメールを運営に送信
    contact = Contact.new(contact_params)
    log_unsubscribe(contact, current_user)

    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message! :notice, :destroyed
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  #退会理由用
  def contact_params
    params.require(:contact).permit(:message)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
    devise_parameter_sanitizer.permit(:sign_up) do |params|
      params.permit(:email, :password, :password_confirmation, :current_password, :name, :tos_acceptance)
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    # devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])

    devise_parameter_sanitizer.permit(:account_update) do |params|
      # params.permit(:email, :password, :password_confirmation, :current_password, :name, :usergenre_list,
      #               user_profile_attributes: [:id, :description, :insta_url, :tw_url, :avatar ])
      #user edit ジャンルのselectbox用
      params.permit(:email, :password, :password_confirmation, :current_password, :name, :tag_list,
                    user_profile_attributes: [:id, :description, :insta_url, :tw_url, :avatar ])
    end
  end

  # By default we want to require a password checks on update.
  # You can overwrite this method in your own RegistrationsController.
  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end

  #マイページ更新後にマイページ表示
  def after_update_path_for(resource)
    users_playlist_path(current_user)
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
