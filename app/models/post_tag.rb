class PostTag < ApplicationRecord
    validates :tag_name, presence: true

    belongs_to :post
    t.timestamps
end
