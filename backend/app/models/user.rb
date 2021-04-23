class User < ApplicationRecord
    validates :username, presence: true
    validates :age, numericality: { greater_than: 18 }
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true

    has_secure_password
    has_many :user_communities
    has_many :community_owners
    has_many :posts
    has_many :comments
    has_many :post_likes
    has_many :communities, through: :user_communities
end
