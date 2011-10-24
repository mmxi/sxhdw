class CreateForums < ActiveRecord::Migration
  def self.up
    create_table :forums do |t|
      t.integer :site_id
      t.string :name
      t.string :description
      t.integer :topics_count, :default => 0
      t.integer :posts_count, :default => 0
      t.integer :position, :default => 0
      t.string :state, :default => "public"
      t.text :description_html
      t.string :permalink

      t.timestamps
    end
    add_index :forums, [:position, :site_id], :name => "index_forums_on_position_and_site_id"
    add_index :forums, [:site_id, :permalink], :name => "index_forums_on_site_id_and_permalink"
  end

  def self.down
    drop_table :forums
  end
end
