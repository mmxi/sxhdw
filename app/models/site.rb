# encoding: utf-8
class Site < ActiveRecord::Base
  validates_presence_of :name, :message => "站点名称不能为空"
  validates_presence_of :host, :message => "站点网址不能为空"
  validates_presence_of :description, :message => "站点描述不能为空"

  has_many :users, :conditions => {:active => true}
  has_many :all_users, :class_name => "User"
  has_many :forums
  has_many :topics, :through => :forums
  has_many :posts, :through => :forums

  attr_readonly :posts_count, :users_count, :topics_count

  default_scope :order => 'created_at DESC'
end
