class Prefecture < ApplicationRecord
    has_many :areas, dependent: :destroy
    has_many :person_infos
end
