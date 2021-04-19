class CreateUserCommunities < ActiveRecord::Migration[6.1]
  def change
    create_table :user_communities do |t|
      t.belongs_to :users, index: true, foreign_key: true
      t.belongs_to :communities, index: true, foreign_key: true

      t.timestamps
    end
  end
end
