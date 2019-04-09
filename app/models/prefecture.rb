class Prefecture < ApplicationRecord
    has_many :areas
    has_many :person_infos
end
