class Track < ApplicationRecord
  belongs_to :list, dependent: :destroy, inverse_of: :tracks
#   has_many :lists
  has_many :item_services, dependent: :destroy
  has_many :music_servises, through: :item_services

  #sortable用
  include RankedModel
  ranks :row_order
  
  #validate
  validates :artist, presence: true
  validates :song, presence: true
end
