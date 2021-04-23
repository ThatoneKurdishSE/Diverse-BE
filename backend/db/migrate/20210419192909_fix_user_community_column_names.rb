class FixUserCommunityColumnNames < ActiveRecord::Migration[6.1]
  def change
    rename_column :user_communities, :users_id, :user_id
    rename_column :user_communities, :communities_id, :community_id
  end
end
