class UserSessionsController < ApplicationController
  layout "home"
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new(:remember_me => true)
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    @login_success = false
    if @user_session.save
      flash[:success] = t("message.Login successful")
      respond_to do |wants|
        wants.js {
          @login_success = true
          @user = (UserSession.find).user
        }
        wants.html { redirect_to "/" }
      end
    else
      flash[:error] = t("message.Login failed")
      #redirect_back_or_default("/login")
      respond_to do |wants|
        wants.js {  }
        wants.html { redirect_to "/login" }
      end
    end
  end

  def destroy
    current_user_session.destroy
    #flash[:notice] = "Logout successful!"
    redirect_to "/login"
  end
end