class MusicService < ApplicationRecord
  has_many :item_services
  has_many :list_items, through: :item_services
end
