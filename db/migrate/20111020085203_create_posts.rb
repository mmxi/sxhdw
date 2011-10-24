class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :site_id
      t.integer :forum_id
      t.integer :user_id
      t.integer :topic_id
      t.text :body
      t.text :body_html
      
      t.timestamps
    end
    add_index :posts, [:created_at, :forum_id], :name => "index_posts_on_forum_id"
    add_index :posts, [:created_at, :topic_id], :name => "index_posts_on_topic_id"
    add_index :posts, [:created_at, :user_id], :name => "index_posts_on_user_id"
  end

  def self.down
    drop_table :posts
  end
end
