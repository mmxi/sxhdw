class AddPostsCountToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :posts_count, :integer
    add_index :users, [:site_id, :posts_count], :name => "index_users_on_site_id_and_posts_count"
  end

  def self.down
    remove_index :users, [:site_id, :posts_count]
    remove_column :users, :posts_count
  end
end
