class AddPhotoToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :photo_file_name, :string
    add_column :users, :photo_content_type, :string
    add_column :users, :photo_file_size, :integer
    add_column :users, :photo_updated_at, :datetime
		add_column :users, :face_url, :string
  end

  def self.down
		remove_column :users, :face_url
    remove_column :users, :photo_file_name
    remove_column :users, :photo_content_type
    remove_column :users, :photo_file_size
    remove_column :users, :photo_updated_at
  end
end
