class Track < ApplicationRecord
  #paranoia 論理削除
  acts_as_paranoid
  
  belongs_to :list, inverse_of: :tracks

  #sortable用
  include RankedModel
  ranks :row_order
  
  #validate
  validates :artist, presence: true, length: { maximum: 90 } 
  validates :song, presence: true, length: { maximum: 50 } 
  validates :description, length: { maximum: 400 } 
  validates :recommend, inclusion: {in: [true, false]}
  validates :row_order, numericality: true
end
