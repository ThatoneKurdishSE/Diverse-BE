class Community < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :location, presence: true
    validates :description, presence: true

    has_many :user_communities
    has_many :users, through: :user_communities
end
