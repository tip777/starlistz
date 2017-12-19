class UserProfile < ApplicationRecord
  belongs_to :user
  has_many :profile_genres
  has_many :user_genres, through: :profile_genres

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
