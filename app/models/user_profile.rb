class UserProfile < ApplicationRecord
  #paranoia 論理削除
  acts_as_paranoid

  # プロフィール画像
  mount_uploader :avatar, AvatarUploader
  
  # has_one :user, inverse_of: :user_profile
  belongs_to :user
  
  #validate
  validates :description, length: { maximum: 400 } #400文字以内
  # validates :insta_url, format: /\A#{URI::regexp(%w(http https))}\z/
  # validates :tw_url, format: /\A#{URI::regexp(%w(http https))}\z/
  
end
