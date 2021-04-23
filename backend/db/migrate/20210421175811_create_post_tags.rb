class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.string :tag_name
      t.belongs_to :posts, index: true, foreign_key: true

      t.timestamps
    end
  end
end
