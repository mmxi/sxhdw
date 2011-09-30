class Admin::ActivitiesController < ApplicationController
  layout "admin"
  include_kindeditor :only => [:new, :edit]
  
  def index
    @activities = Activity.order("updated_at desc").paginate(:page => params[:page]||1, :per_page => 10)
  end
  
  def new
    @activity = Activity.new
    @activity.build_act_text

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @activity }
    end
  end

  def edit
    @activity = Activity.find(params[:id])
    @activity.start_time = @activity.start_time.strftime("%Y-%m-%d %H:%M")
    @activity.end_time = @activity.end_time.strftime("%Y-%m-%d %H:%M")
  end

  def create
    @activity = Activity.new(params[:activity])
    #@act_text = ActText.new(params[:act_text])
    
    respond_to do |wants|
      if @activity.save
        wants.html { redirect_to(admin_activities_url, :notice => 'Activity was successfully created.') }
      else
        format.html { render :action => "new" }
      end
      
    end
  end

  def update
    @activity = Activity.find(params[:id])

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to(admin_activities_url, :notice => 'Activity was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to(admin_activities_url) }
      format.xml  { head :ok }
    end
  end
end
