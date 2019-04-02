class PersonInfo < ApplicationRecord
    #paranoia 論理削除
    acts_as_paranoid
    
    belongs_to :user, -> { unscope(where: :deleted_at) } #paranoia制約なし
    
    ## Validation
    validates :first_name, presence: true, length: { maximum: 35 }
    validates :last_name, presence: true, length: { maximum: 35 }
    validates :first_name_kana, presence: true, length: { maximum: 35 }, format: { with: /\A(?:\p{Katakana}|[ー－])+\z/ }
    validates :last_name_kana, presence: true, length: { maximum: 35 }, format: { with: /\A(?:\p{Katakana}|[ー－])+\z/ }
    # validates :birthday, presence: true　#:birthdayはcontroller側でvalidateする
    # validates :zipcode, numericality: true, length: { maximum: 7 }
    validates :prefecture, presence: true, length: { maximum: 35 } #リストボックス以外のだったらはじくようにする
    validates :city, presence: true, length: { maximum: 50 }
    validates :address1, presence: true, length: { maximum: 100 }
    validates :address2, length: { maximum: 100 }
    validates :phone_number, length: { maximum: 20 }, numericality: true, allow_nil: true
    
end
