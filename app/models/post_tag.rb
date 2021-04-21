class PostTag < ApplicationRecord
    validates :tag_name, presence: true

    belongs_to :posts
    t.timestamps
end
