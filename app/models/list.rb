class List < ApplicationRecord
  belongs_to :user
  has_many :list_favorites, dependent: :destroy

  has_many :list_items, dependent: :destroy

  has_many :purchases, dependent: :destroy
  has_many :users, through: :users

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  #gem acts-as-taggable-on タグ機能
  acts_as_ordered_taggable_on :maingenres, :othergenres
end
