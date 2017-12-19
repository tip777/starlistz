class UserFavorite < ApplicationRecord
  belongs_to :favoriting
  belongs_to :fovorited
end
