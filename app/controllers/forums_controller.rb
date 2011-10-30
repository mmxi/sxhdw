# encoding: utf-8
class ForumsController < ApplicationController
  layout "forum"

  add_breadcrumb "首页", :root_path
  add_breadcrumb "论坛", :forums_path

  def index
    @parent_forums = current_site.forums.top
    @topics = current_site.topics.paginate(:page => params[:page]||1, :per_page => 10, :include => [:user, :forum, :last_user])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    id = params[:id]
    @forum = current_site.forums.find(id)
    add_breadcrumb @forum.name, forum_path(@forum)
    if @forum.parent_id == nil
      render :template => "forums/cforums"
    else
      @topics = @forum.topics.all(:include => [:user, :forum, :last_user])
      @topic = @forum.topics.new
    end
    rescue
      redirect_to :action => "index"
  end
end
