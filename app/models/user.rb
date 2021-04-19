class User < ApplicationRecord
    has_secure_password
    has_many :communities, through: :user_communities
    has_many :user_communities
end
