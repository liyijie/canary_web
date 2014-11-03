class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.integer :followed_id
      t.integer :follower_id

      t.timestamps
    end
    add_index :relations, :followed_id
    add_index :relations, :follower_id
  end
end
