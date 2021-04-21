class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, length: { minimum: 1, maximum: 750 }
    validates :ip_address, presence: true

    belongs_to :users
    belongs_to :communities
    t.timestamps
end
