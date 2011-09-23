class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.integer :user_id
      t.string  :act_subject
      t.string  :act_type
      t.string  :act_place
      t.integer :view_count
      t.integer :comment_count
      t.datetime  :start_time
      t.datetime  :end_time
      t.timestamps
    end
    add_index :activities, :view_count, :name => "act_view_count"
    add_index :activities, [:start_time, :end_time], :name => "act_start_end_time"
    add_index :activities, [:user_id, :act_subject, :act_type], :name => "act_user_subject_type"
    add_index :activities, [:user_id, :comment_count, :start_time], :name => "user_comment_count_start_time"
  end

  def self.down
    drop_table :activities
  end
end
