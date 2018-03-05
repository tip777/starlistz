class List < ApplicationRecord
  belongs_to :user
  has_many :list_favorites, dependent: :destroy

  has_many :tracks, dependent: :destroy
  accepts_nested_attributes_for :tracks, reject_if: :all_blank, allow_destroy: true

  has_many :purchases
  # has_many :users, through: :users

  #プレイリストお気に入り機構
  has_many :list_favorites, dependent: :destroy
  has_many :favorite_lists, through: :list_favorites, source: :user

  # #gem acts-as-taggable-on タグ機能
  acts_as_taggable

  #paperclip設定
  has_attached_file :image,
                    :storage => :s3,
                    :s3_credentials => Proc.new{|a| a.instance.s3_credentials },
                    :styles => {
                      :thumb => "100x100#",
                      :medium => '300x240#'
                    }, default_url: "/images/default/thumb_noimage.png"

  def s3_credentials
      {:bucket => 'starlistz-bucket', :aws_access_key_id => ENV["AWS_ACCESS_KEY_ID"], :aws_secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"]}
  end
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  do_not_validate_attachment_file_type :image

  #validation
  #これから

  #５曲以上入っているか確認　validation作業に入ったらコメント外す
  # after_save do
  #   if self.tracks.count <= 5
  #     self.errors.add(:base, "５曲以上登録してください")
  #     raise ActiveRecord::Rollback
  #   end
  # end
end
