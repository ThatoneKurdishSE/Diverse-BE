class FixColumnPluralityInForeignKeys < ActiveRecord::Migration[6.1]
  def change
    rename_column :post_likes, :posts_id, :post_id
    rename_column :post_likes, :users_id, :user_id
    rename_column :post_tags, :posts_id, :post_id
    rename_column :posts, :users_id, :user_id
    rename_column :posts, :communities_id, :community_id
  end
end
