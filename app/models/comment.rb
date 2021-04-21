class Comment < ApplicationRecord
    validates :content, length: { minimum: 1, maximum: 750 }
    belongs_to :user
    belongs_to :post
end
