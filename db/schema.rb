# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111025123833) do

  create_table "act_texts", :force => true do |t|
    t.integer "activity_id"
    t.text    "act_description"
  end

  add_index "act_texts", ["activity_id"], :name => "act_index"

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.string   "act_subject"
    t.string   "act_type"
    t.string   "act_place"
    t.integer  "view_count"
    t.integer  "comment_count"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["start_time", "end_time"], :name => "act_start_end_time"
  add_index "activities", ["user_id", "act_subject", "act_type"], :name => "act_user_subject_type"
  add_index "activities", ["user_id", "comment_count", "start_time"], :name => "user_comment_count_start_time"
  add_index "activities", ["view_count"], :name => "act_view_count"

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  create_table "forums", :force => true do |t|
    t.integer  "site_id"
    t.string   "name"
    t.string   "description"
    t.integer  "topics_count",     :default => 0
    t.integer  "posts_count",      :default => 0
    t.integer  "position",         :default => 0
    t.string   "state",            :default => "public"
    t.text     "description_html"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.string   "css_name"
  end

  add_index "forums", ["position", "site_id"], :name => "index_forums_on_position_and_site_id"
  add_index "forums", ["site_id", "permalink"], :name => "index_forums_on_site_id_and_permalink"

  create_table "posts", :force => true do |t|
    t.integer  "site_id"
    t.integer  "forum_id"
    t.integer  "user_id"
    t.integer  "topic_id"
    t.text     "body"
    t.text     "body_html"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["created_at", "forum_id"], :name => "index_posts_on_forum_id"
  add_index "posts", ["created_at", "topic_id"], :name => "index_posts_on_topic_id"
  add_index "posts", ["created_at", "user_id"], :name => "index_posts_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "settings", :force => true do |t|
    t.string   "var",                       :null => false
    t.text     "value"
    t.integer  "target_id"
    t.string   "target_type", :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["target_type", "target_id", "var"], :name => "index_settings_on_target_type_and_target_id_and_var", :unique => true

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "host"
    t.integer  "topics_count", :default => 0
    t.integer  "posts_count",  :default => 0
    t.integer  "users_count",  :default => 0
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sns_activity_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.boolean  "attendee"
    t.boolean  "interest"
    t.boolean  "share"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sns_activity_users", ["activity_id"], :name => "index_sns_activity_users_on_activity_id"
  add_index "sns_activity_users", ["user_id"], :name => "index_sns_activity_users_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type"], :name => "index_taggings_on_tag_id_and_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  add_index "tags", ["name"], :name => "index_tags_on_name"

  create_table "topics", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "title"
    t.integer  "hits",            :default => 0
    t.integer  "sticky",          :default => 0
    t.integer  "posts_count",     :default => 0
    t.boolean  "locked",          :default => false
    t.integer  "last_post_id"
    t.datetime "last_updated_at"
    t.integer  "last_user_id"
    t.integer  "site_id"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["forum_id", "permalink"], :name => "index_topics_on_forum_id_and_permalink"
  add_index "topics", ["last_updated_at", "forum_id"], :name => "index_topics_on_last_updated_at_and_forum_id"
  add_index "topics", ["sticky", "last_updated_at", "forum_id"], :name => "index_topics_on_sticky_and_last_updated_at"

  create_table "users", :force => true do |t|
    t.string   "login",                                 :null => false
    t.string   "nickname"
    t.string   "email",                                 :null => false
    t.string   "crypted_password",                      :null => false
    t.string   "password_salt",                         :null => false
    t.string   "persistence_token",                     :null => false
    t.string   "perishable_token",                      :null => false
    t.integer  "login_count",        :default => 0
    t.integer  "failed_login_count", :default => 0
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "info"
    t.boolean  "active",             :default => false, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "face_url"
    t.integer  "site_id"
    t.integer  "posts_count"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token", :unique => true
  add_index "users", ["site_id", "posts_count"], :name => "index_users_on_site_id_and_posts_count"

end
