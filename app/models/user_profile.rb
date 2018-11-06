class UserProfile < ApplicationRecord
  #paranoia 論理削除
  acts_as_paranoid
  
  has_one :user, inverse_of: :user_profile
    
  has_attached_file :avatar,
                    :storage => :s3,
                    :s3_credentials => Proc.new{|a| a.instance.s3_credentials },
                    :styles => {
                      :thumb => "100x100#",
                      :medium => '300x240#'
                    }, default_url: "/default/thumb_noavatar.jpg"

  def s3_credentials
      {:bucket => ENV["S3_BUCKET_NAME"], :aws_access_key_id => ENV["AWS_ACCESS_KEY_ID"], :aws_secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"]}
  end
  
  def authenticated_image_url(style)
      avatar.s3_object(style).url_for(:read, :secure => true)
  end
  
  #validate
  validates :description, length: { maximum: 400 } #400文字以内
  # validates :insta_url, format: /\A#{URI::regexp(%w(http https))}\z/
  # validates :tw_url, format: /\A#{URI::regexp(%w(http https))}\z/
  #プロフィール画像 validate
  validates_attachment_content_type :avatar, :content_type => ["image/png", "image/jpg", "image/jpeg"]
  do_not_validate_attachment_file_type :avatar

  
end
