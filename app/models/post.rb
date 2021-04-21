class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, length: { minimum: 1, maximum: 750 }
    validates :ip_address, presence: true

    belongs_to :user
    belongs_to :community
    t.timestamps
end
