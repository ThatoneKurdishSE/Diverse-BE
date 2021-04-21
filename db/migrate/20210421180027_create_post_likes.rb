class CreatePostLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :post_likes do |t|
      t.belongs_to :posts, index: true, foreign_key: true
      t.belongs_to :users, index: true, foreign_key: true

      t.timestamps
    end
  end
end
