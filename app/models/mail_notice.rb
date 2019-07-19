class MailNotice < ApplicationRecord
    belongs_to :user

    validates :news_letter, inclusion: {in: [true, false]}
    validates :list_sold, inclusion: {in: [true, false]}
end
