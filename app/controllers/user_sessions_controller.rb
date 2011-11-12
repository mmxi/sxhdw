# encoding: utf-8
class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new(:remember_me => true)
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    respond_to do |format|
      if @user_session.save
        flash[:success] = "登录成功"
        format.html { redirect_to user_path(@user_session.user) }
        format.js { render :text => "window.location.reload();" }
      else
        flash[:error] = "登录失败"
        format.html { redirect_to login_path }
        format.js { render :text => "window.location.reload();" }
      end
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to login_path
  end
end
