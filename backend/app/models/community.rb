class Community < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :location, presence: true
    validates :description, presence: true

    has_many :user_communities
    has_one :community_owner
    has_many :posts
    has_many :comments, through: :posts
    has_many :post_likes, through: :posts
    has_many :post_tags, through: :posts
    has_many :users, through: :user_communities
    has_many :users, through: :community_owners
end
