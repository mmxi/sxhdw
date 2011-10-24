class CreateSnsActivityUsers < ActiveRecord::Migration
  def self.up
    create_table :sns_activity_users do |t|
      t.integer :user_id
      t.integer :activity_id
      t.boolean :attendee
      t.boolean :interest
      t.boolean :share
      t.timestamps
    end
    add_index :sns_activity_users, :user_id
    add_index :sns_activity_users, :activity_id
  end

  def self.down
    drop_table :sns_activity_users
  end
end
