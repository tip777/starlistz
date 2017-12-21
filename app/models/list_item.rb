class ListItem < ApplicationRecord
  has_many :list_contents, dependent: :destroy
  has_many :lists, through: :list_contents
  has_many :item_services, dependent: :destroy
  has_many :music_servises, through: :item_services
end
