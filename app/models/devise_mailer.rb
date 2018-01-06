class DeviseMailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: 'devise/mailer'

  def confirmation_instructions(record, token, opts={})
    super
  end

  def reset_password_instructions(record, token, opts={})
    super
  end

  def unlock_instructions(record, token, opts={})
    super
  end

  # 新規追加
  #新規登録　confirmation_on_create_instructions
  #メールアドレス変更　confirmation_instructions
  def confirmation_on_create_instructions(record, token, opts={})
    @token = token
    devise_mail(record, :confirmation_on_create_instructions, opts)
  end

end
