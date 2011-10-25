class Admin::ForumsController < ApplicationController
  before_filter :require_user
  layout "admin"

  def index
    @forums = Forum.expand_tree(current_site.forums.top)
  end

  def new
    @forum = current_site.forums.new
    @page_title = "创建新版块"
  end

  def edit
    @forum = Forum.find(params[:id])
  end

  def create
    @forum = current_site.forums.build(params[:forum])

    if @forum.save
      flash[:success] = "创建成功"
      redirect_to admin_forums_path
    else
      render :action => "new"
    end
  end

  def update
    @forum = current_site.forums.find(params[:id])

    if @forum.update_attributes(params[:forum])
      flash[:success ] = "更新成功"
      redirect_to admin_forums_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @forum = current_site.forums.find(params[:id])
    @forum.destroy
    redirect_to admin_forums_path
  end
end
