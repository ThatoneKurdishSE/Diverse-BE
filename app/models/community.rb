class Community < ApplicationRecord
    has_many :users, through: :user_communities
    has_many :users
end
