class PersonInfo < ApplicationRecord
    #paranoia 論理削除
    acts_as_paranoid
    
    belongs_to :user, -> { unscope(where: :deleted_at) } #paranoia制約なし
    
    belongs_to :prefecture
    
    ## Validation
    validates :first_name, presence: true, length: { maximum: 35 }
    validates :last_name, presence: true, length: { maximum: 35 }
    validates :first_name_kana, presence: true, length: { maximum: 35 }, format: { with: /\A(?:\p{Katakana}|[ー－])+\z/ }
    validates :last_name_kana, presence: true, length: { maximum: 35 }, format: { with: /\A(?:\p{Katakana}|[ー－])+\z/ }
    validates :zipcode, numericality: true, length: { maximum: 7 }
    validates :city, presence: true, length: { maximum: 50 }
    validates :address1, presence: true, length: { maximum: 100 }
    validates :address2, length: { maximum: 100 }
    validates :phone_number, length: { maximum: 20 }, numericality: true, allow_blank: true

    #郵便番号存在チェック
    before_validation do
        if Area.where(postal_code: self.zipcode).empty?
            self.errors.add(:zipcode, "が不正です")
        end
    end
    
end
