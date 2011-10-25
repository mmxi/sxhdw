class Forum < ActiveRecord::Base
  belongs_to :site
  has_many :topics

  acts_as_tree :order => 'position'

  validates_presence_of :name, :message => "论坛名字不能为空"
  validates_presence_of :site_id

  attr_readonly :topics_count, :posts_count

  def self.top
    find(:all, :conditions => [ 'parent_id IS NULL' ], :order => 'position')
  end
  
  def has_children?
    children.size > 0
  end

  def self.render_tree_list
    parent_forums = Forum.top
    expand_tree parent_forums
  end

  def self.expand_tree(forums)
    returning(Array.new) do |output|
      forums.each do |forum|
        output << forum
        output.concat expand_tree(forum.children) if forum.has_children?
      end
    end
  end
end
