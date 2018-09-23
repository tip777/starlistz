class Purchase < ApplicationRecord
  #paranoia 論理削除
  acts_as_paranoid
  
  belongs_to :user, -> { unscope(where: :deleted_at) } #paranoia制約なし
  belongs_to :list, -> { unscope(where: :deleted_at) } #paranoia制約なし
  
  validates :user_id, :uniqueness => {:scope => :list_id}
end
