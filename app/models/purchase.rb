class Purchase < ApplicationRecord
  #paranoia 論理削除
  acts_as_paranoid
  
  belongs_to :user
  belongs_to :list
  
  validates :user_id, :uniqueness => {:scope => :list_id}
end
