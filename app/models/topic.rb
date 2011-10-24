class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum, :counter_cache => true
  belongs_to :site, :counter_cache => true
  belongs_to :last_user, :class_name => "User"

  has_one  :recent_post, :class_name => "Post"
  has_many :posts, :dependent => :destroy

  validates_presence_of :title, :message => "标题不能为空"
  validates_presence_of :body, :on => :create, :message => "帖子内容不能为空"
  validates_presence_of :site_id, :forum_id, :user_id

  before_validation :set_default_attributes, :on => :create
  before_save  :generate_permalink
  after_create   :create_initial_post
  before_update  :check_for_moved_forum
  after_update   :set_post_forum_id
  before_destroy :count_user_posts_for_counter_cache
  after_destroy  :update_cached_forum_and_user_counts
  
  attr_accessor :body
  attr_accessible :title, :body
  attr_readonly :posts_count, :hits

  has_permalink :title, :scope => :forum_id

  def sticky?
    sticky == 1
  end

  def hit!
    self.class.increment_counter :hits, id
  end

  def to_param
    permalink
  end

  def update_cached_post_fields(post)
    if remaining_post = post.frozen? ? recent_post : post
      self.class.where(:id => id).update_all(:last_updated_at => remaining_post.created_at, :last_user_id => remaining_post.user_id, :last_post_id => remaining_post.id, :posts_count => posts.count)
    else
      destroy
    end
  end
  
  protected
    def generate_permalink
      self.permalink = GoogleTranslate::translate(title).gsub(/[^a-z1-9]+/i, '-')
    end

  def set_default_attributes
      self.site_id = forum.site_id if forum_id
      self.sticky ||= 0
      self.last_updated_at ||= Time.now.utc
    end

    def create_initial_post
      user.posts.build(:body => body).tap do |post|
        post.topic = self
        post.forum = self.forum
        post.site = self.site
        post.save
      end
    end

    def check_for_moved_forum
      old = Topic.find(id)
      @old_forum_id = old.forum_id if old.forum_id != forum_id
      true
    end

    def set_post_forum_id
      return unless @old_forum_id
      posts.update_all(:forum_id => forum_id)
      Forum.where(:id => @old_forum_id).update_all("posts_count = posts_count - #{posts_count}")
      Forum.where(:id => forum_id).update_all("posts_count = posts_count + #{posts_count}")
    end
  
    def count_user_posts_for_counter_cache
      @user_posts = posts.group_by { |p| p.user_id }
    end

    def update_cached_forum_and_user_counts
      Forum.where(:id => forum_id).update_all("posts_count = posts_count - #{posts_count}")
      Site.where(:id => site_id).update_all("posts_count = posts_count - #{posts_count}")
      @user_posts.each do |user_id, posts|
        User.where(:id => user_id).update_all("posts_count = posts_count - #{posts.size}")
      end
    end
end
