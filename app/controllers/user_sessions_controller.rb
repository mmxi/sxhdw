class UserSessionsController < ApplicationController
  layout "home"
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new(:remember_me => true)
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:success] = "登录成功"
      redirect_to user_path(UserSession.find.user)
    else
      flash[:error] = "登录失败"
      redirect_to login_path
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to login_path
  end
end
