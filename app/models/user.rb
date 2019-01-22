class User < ApplicationRecord
  before_validation :downcase_username

  #paranoia 論理削除
  acts_as_paranoid

  #gem acts-as-taggable-on タグ機能
  acts_as_taggable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        # :recoverable, :rememberable, :trackable, :validatable,
        #:rememberableを削除
        :recoverable, :trackable, :validatable,
        # :confirmable, :timeoutable, :omniauthable, omniauth_providers: [:twitter]
        :timeoutable, :omniauthable, omniauth_providers: [:twitter] #cloud9用

  #relation
  #フォロー機能
  has_many :following_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_users, through: :following_relationships, source: :followed

  has_many :follower_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower

  belongs_to :user_profile, dependent: :destroy, inverse_of: :user, optional: true
  accepts_nested_attributes_for :user_profile, allow_destroy: true

  has_many :lists, dependent: :destroy

  #プレイリストお気に入り
  has_many :list_favorites, dependent: :destroy
  has_many :favorite_lists, through: :list_favorites, source: :list

  has_many :purchases, dependent: :destroy

  has_many :social_profiles, dependent: :destroy

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

  # override Devise::Models::Confirmable#resend_confirmation_instructions
  # 本登録の再送信の際はsend_on_create_confirmation_instructionsで本登録のメールを送る
  def resend_confirmation_instructions
    pending_any_confirmation do
      # send_confirmation_instructions
      send_on_create_confirmation_instructions
    end
  end

  # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end

  def favorite(list)
    list_favorites.find_or_create_by(list_id: list.id)
  end

  #お気に入り削除
  def unfavorite(list)
    favorite = list_favorites.find_by(list_id: list.id)
    favorite.destroy if favorite_lists
  end

  def favorite?(list)
    favorite_lists.include?(list)
  end


  #Validate
  #ユーザー名　validate
  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }, user_name: true #空はダメ、一意性をもつ、30文字以内
  #利用規約の同意しているかチェック
  validates_acceptance_of :tos_acceptance, allow_nil: false, on: :create, message: "にチェックが入っていません。"
  #ジャンルvalidate (日本語、英語、英数字、アンダーバーのみ)
  validates :tag_list, tag: true

  private

  #ユーザー名を小文字にする
  def downcase_username
    self.name = self.name.downcase
  end

  #ジャンルは30個まで
  before_save do
    if self.tag_list.count > 30
      extra_tags = self.tag_list.count - 30
      self.tag_list.slice!(30, self.tag_list.count - 1)
    end
  end

  #ジャンルは99文字まで
  before_save do
    self.tag_list.each_with_index do |val, i|
      if  self.tag_list[i].length > 99
        self.tag_list[i] = self.tag_list[i].slice(0, 98)
      end
    end
  end

end
