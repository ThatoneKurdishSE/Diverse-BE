class PostTag < ApplicationRecord
    validates :tag_name, length: { minimum: 1, maximum: 50 }

    belongs_to :post
    t.timestamps
end
