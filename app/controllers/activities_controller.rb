# encoding: utf-8
class ActivitiesController < ApplicationController
  before_filter :require_user, :only => [:join]
  layout "home"

  def index
    @activities = Activity.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @activities }
    end
  end

  def show
    id = params[:id].to_i
    @activity = Activity.find(id)
    #@sns_join_users = User.joins(:sns_activity_users).where({:activity_id => id, :join => true})
    @sns_join_users = @activity.join_users

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @activity }
    end
  end
  
  def join
    id = params[:id].to_i
    my_activity = current_user.sns_activity_users.find_by_activity_id(id)
    respond_to do |wants|
      if my_activity
        my_activity.attendee = true
        my_activity.save
        wants.js {  }
        wants.html { render :text => 'text to render' }
      else
        current_user.sns_activity_users.create(:activity_id => id, :attendee => true)
        wants.js {  }
      end
    end
  end
  
end
