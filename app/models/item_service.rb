class ItemService < ApplicationRecord
  belongs_to :music_service
  belongs_to :list_item
end
