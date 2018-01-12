class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
        # :confirmable, :timeoutable, :omniauthable, omniauth_providers: [:twitter]
        :timeoutable, :omniauthable, omniauth_providers: [:twitter] #cloud9用

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
      end
    else
      super
    end
  end

  # allow users to update their accounts without passwords
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  # override Devise::Models::Confirmable#send_on_create_confirmation_instructions
  # 新規登録、メールアドレス変更とテンプレートを分ける
  #　新規登録　confirmation_on_create_instructions
  #  メールアドレス変更　confirmation_instructions
  def send_on_create_confirmation_instructions
    generate_confirmation_token!  unless @raw_confirmation_token
    send_devise_notification(:confirmation_on_create_instructions, @raw_confirmation_token, {})
  end

  belongs_to :user_profile, dependent: :destroy, inverse_of: :user, optional: true
  accepts_nested_attributes_for :user_profile, allow_destroy: true

  has_many :list_favorites, dependent: :destroy

  has_many :lists, dependent: :destroy

  has_many :purchases, dependent: :destroy
  # has_many :lists, through: :purchases

  has_many :favoriting_relation, class_name: "User_favorite", foreign_key: "favoriting_id", dependent: :destroy
  has_many :favoriting_users, through: :favoriting_relation, source: :favoriter

  has_many :favoriter_relation, class_name: "User_favorite", foreign_key: "favoriter_id", dependent: :destroy
  has_many :favoriter_users, through: :favoriter_relation, source: :favoriting



  #gem acts-as-taggable-on タグ機能
  acts_as_ordered_taggable_on :usergenres

  #ユーザー名　validate
  validates :name, presence: true, uniqueness: true, length: { minimum: 1,maximum: 50 }

end
