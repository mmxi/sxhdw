module ForumsHelper
  def hot_forums
    current_site.forums.limit(20).where("parent_id > ?", 0).order("topics_count DESC")
  end
end
