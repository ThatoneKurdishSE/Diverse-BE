class CreateCommunityOwners < ActiveRecord::Migration[6.1]
  def change
    create_table :community_owners do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :community, index: true, foreign_key: true

      t.timestamps
    end
  end
end
