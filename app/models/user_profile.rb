class UserProfile < ApplicationRecord
  has_one :user, inverse_of: :user_profile
    
  has_attached_file :avatar,
                    :storage => :s3,
                    :s3_credentials => Proc.new{|a| a.instance.s3_credentials },
                    :styles => {
                      :thumb => "100x100#",
                      :medium => '300x240#'
                    }, default_url: "/images/default/thumb_noavatar.jpg"

  def s3_credentials
      {:bucket => 'starlistz-bucket', :aws_access_key_id => ENV["AWS_ACCESS_KEY_ID"], :aws_secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"]}
  end
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  do_not_validate_attachment_file_type :avatar
  
  def authenticated_image_url(style)
      avatar.s3_object(style).url_for(:read, :secure => true)
  end
  
  #validate
  validates :description, length: { maximum: 400 } #400文字以内
  # validates :insta_url, format: /\A#{URI::regexp(%w(http https))}\z/
  # validates :tw_url, format: /\A#{URI::regexp(%w(http https))}\z/


  
end
