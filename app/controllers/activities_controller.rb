class ActivitiesController < ApplicationController
  layout "home"
  include_kindeditor :only => [:new, :edit]
  
  def index
    @activities = Activity.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @activities }
    end
  end

  def show
    @activity = Activity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @activity }
    end
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
        wants.html { redirect_to(@activity, :notice => 'Activity was successfully created.') }
      else
        format.html { render :action => "new" }
      end
      
    end
  end

  def update
    @activity = Activity.find(params[:id])

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to(@activity, :notice => 'Activity was successfully updated.') }
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
      format.html { redirect_to(activities_url) }
      format.xml  { head :ok }
    end
  end
end
