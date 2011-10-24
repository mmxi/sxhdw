class ForumsController < ApplicationController
  layout "forum"
  
  def index
    @topics = current_site.topics.paginate(:page => params[:page]||1, :per_page => 10, :include => [:user, :forum, :last_user])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @forum = current_site.forums.find(params[:id])
    @topics = @forum.topics.all(:include => [:user, :forum, :last_user])
    @topic = @forum.topics.new
  end
end
