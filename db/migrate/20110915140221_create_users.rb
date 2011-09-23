class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string    :nickname
      t.string    :email
      t.string    :crypted_password
      t.string    :password_salt
      t.string    :persistence_token
      #t.string    :single_access_token, :null => false                # optional, see Authlogic::Session::Params
      #t.string    :perishable_token,    :null => false                # optional, see Authlogic::Session::Perishability

      # magic fields (all optional, see Authlogic::Session::MagicColumns)
      t.integer   :login_count, :default => 0
      t.integer   :failed_login_count, :default => 0
      t.datetime  :last_request_at
      t.datetime  :current_login_at
      t.datetime  :last_login_at
      t.string    :current_login_ip
      t.string    :last_login_ip
      t.timestamps
    end

    add_index :users, ["email"], :name => "index_users_on_email", :unique => true
    add_index :users, ["persistence_token"], :name => "index_users_on_persistence_token", :unique => true

  end

  def self.down
    drop_table :users
  end
end