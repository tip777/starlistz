class UserFavorite < ApplicationRecord
  belongs_to :favoriting, class_name: "User"
  belongs_to :favoriter, class_name: "User"
end
