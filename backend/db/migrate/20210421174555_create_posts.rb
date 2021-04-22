class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :ip_address
      t.belongs_to :users, index: true, foreign_key: true
      t.belongs_to :communities, index: true, foreign_key: true

      t.timestamps
    end
  end
end
