class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string :name
      t.string :host
      t.integer :topics_count, :default => 0
      t.integer :posts_count, :default => 0
      t.integer :users_count, :default => 0
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
