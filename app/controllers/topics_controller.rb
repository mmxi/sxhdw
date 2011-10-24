class TopicsController < ApplicationController
  before_filter :require_user, :only => [:new, :create]
  before_filter :find_forum
  before_filter :find_topic, :only => [:show, :edit, :update, :destroy]
  
  layout "home"

  def new
    @topic = @forum.topics.new
  end

  def show
    @topic.hit! unless logged_in? && @topic.user_id == current_user.id
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @topic = @forum.topics.build(params[:topic])
    @topic.user = current_user
    respond_to do |format|
      if @topic.save
        format.html { redirect_to forum_topic_path(@forum, @topic) }
        format.js
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @topic.title = params[:topic][:title]
    respond_to do |format|
      if @topic.save
        format.html do
          flash[:success] = "更新成功"
          redirect_to forum_topic_path(@forum, @topic)
        end
        format.js
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @topic.destroy
    respond_to do |format|
      format.html do
        flash[:notice] = "主题删除成功"
        redirect_to @forum
      end
      format.js
    end
  end
  
  protected
    def find_forum
      @forum = current_site.forums.find_by_id(params[:forum_id])
    end

    def find_topic
      @topic = @forum.topics.find_by_permalink!(params[:id])
    end
end
