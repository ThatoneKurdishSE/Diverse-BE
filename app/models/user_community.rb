class UserCommunity < ApplicationRecord
    validates :user_id, presence: true
    validates :community_id, presence: true

    belongs_to :user
    belongs_to :community
end
