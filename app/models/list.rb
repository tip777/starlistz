class List < ApplicationRecord
  #paranoia 論理削除
  acts_as_paranoid
  
  ##Scope
  #公開状態かどうか
  scope :is_status, -> { where(status: "release") }
  
  ##Relation
  belongs_to :user, -> { unscope(where: :deleted_at) } #paranoia制約なし
  has_many :list_favorites, dependent: :destroy

  has_many :tracks, -> { unscope(where: :deleted_at) }, inverse_of: :list, dependent: :destroy #paranoia制約なし
  accepts_nested_attributes_for :tracks, reject_if: :all_blank, allow_destroy: true

  has_many :purchases, dependent: :destroy
  # has_many :users, through: :users

  #プレイリストお気に入り機能
  has_many :list_favorites, dependent: :destroy
  has_many :favorite_lists, through: :list_favorites, source: :user

  # #gem acts-as-taggable-on タグ機能
  acts_as_taggable
  

  ## Validation
  #ジャンルvalidate (日本語、英語、英数字、アンダーバーのみ)
  validates :tag_list, tag: true
  
  validates :title, presence: true, length: { maximum: 50 }, list_title: true
  validates :description, presence: true, length: { maximum: 400 } 
  # validates :price, presence: true, numericality: true, :numericality => { :greater_than_or_equal_to => 100, :less_than_or_equal_to => 5000 }
  validates :price, presence: true, numericality: true
  validates_numericality_of :price,  greater_than_or_equal_to: 100
  validates_numericality_of :price,  less_than_or_equal_to: 5000
  
  #５曲以上入っているか確認　validation作業に入ったらコメント外す（削除済みの曲は除外）
  after_save do
    if self.tracks.without_deleted.count < 5
      self.errors.add(:base, "５曲以上登録してください。")
      raise ActiveRecord::Rollback
    end
  end
  
  #ムードは1個以上 30個まで
  before_save do
    if self.tag_list.count == 0
      self.errors.add(:base, "ムードは1つ以上入力してください。")
      raise ActiveRecord::Rollback
    end
    
    if self.tag_list.count > 30
      extra_tags = self.tag_list.count - 30
      self.tag_list.slice!(30, self.tag_list.count - 1) 
    end
  end
  
  #ムードは99文字まで
  before_save do
    self.tag_list.each_with_index do |val, i|
      if  self.tag_list[i].length > 99
        self.tag_list[i] = self.tag_list[i].slice(0, 98)
      end
    end
  end
  
end
