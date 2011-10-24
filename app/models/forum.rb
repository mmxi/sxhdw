class Forum < ActiveRecord::Base
  belongs_to :site
  has_many :topics
  
  validates_presence_of :name, :message => "论坛名字不能为空"
  validates_presence_of :site_id

  attr_readonly :topics_count, :posts_count
end
