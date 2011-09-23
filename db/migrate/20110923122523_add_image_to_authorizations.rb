class AddImageToAuthorizations < ActiveRecord::Migration
  def self.up
    add_column :authorizations, :image, :string
  end

  def self.down
    remove_column :authorizations, :image
  end
end