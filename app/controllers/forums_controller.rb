# encoding: utf-8
class ForumsController < ApplicationController

  add_breadcrumb "首页", :root_path
  add_breadcrumb "论坛", :forums_path

  include_kindeditor :only => [:show]

  def index
    @parent_forums = current_site.forums.top
    @topics = current_site.topics.paginate(:page => params[:page]||1, :per_page => 20, :include => [:user, :forum, :last_user], :order => "created_at DESC")
    respond_to do |format|
      format.html {render :stream => true}
      format.js
    end
  end

  def show
    id = params[:id]
    @forum = current_site.forums.find(id)
    add_breadcrumb @forum.name, forum_path(@forum)
    if @forum.parent_id == nil
      redirect_to forums_path
    else
      @topics = @forum.topics.paginate(:page => params[:page]||1, :per_page => 20, :include => [:user, :forum, :last_user], :order => "created_at DESC")
      @topic = @forum.topics.new
    end
    rescue
      redirect_to forums_path
  end
end
