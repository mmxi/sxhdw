class Post < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  belongs_to :topic, :counter_cache => true
  belongs_to :forum, :counter_cache => true
  belongs_to :site, :counter_cache => true

  before_save :set_body_html
  after_create  :update_cached_fields
  after_destroy :update_cached_fields
  
  protected
    def update_cached_fields
      topic.update_cached_post_fields(self)
    end

    def set_body_html
      self.body_html = RedCloth.new(self.body.to_s).to_html(:textile, :refs_smiley)
    end
end
