class AddCssNameToForums < ActiveRecord::Migration
  def self.up
    add_column :forums, :css_name, :string
  end

  def self.down
    remove_column :forums, :css_name
  end
end
