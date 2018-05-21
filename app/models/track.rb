class Track < ApplicationRecord
  belongs_to :list, inverse_of: :tracks
#   has_many :lists
  has_many :item_services, dependent: :destroy
  has_many :music_servises, through: :item_services

  #sortable用
  include RankedModel
  ranks :row_order
  
  #validate
  validates :artist, presence: true, length: { maximum: 50 } 
  validates :song, presence: true, length: { maximum: 50 } 
  validates :description, length: { maximum: 400 } 
  validates :recommend, inclusion: {in: [true, false]}
  validates :row_order, numericality: true
end
