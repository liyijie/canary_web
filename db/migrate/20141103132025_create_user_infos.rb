class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.integer :sex
      t.string :nickname
      t.date :birth
      t.string :destination
      t.integer :hotel_type
      t.string :flight
      t.string :train
      t.string :wechat
      t.string :qq

      t.timestamps
    end
    add_index :user_infos, :sex
  end
end
