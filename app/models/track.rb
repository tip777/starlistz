class Track < ApplicationRecord
  belongs_to :list, dependent: :destroy, inverse_of: :tracks
#   has_many :lists
  has_many :item_services, dependent: :destroy
  has_many :music_servises, through: :item_services
end
