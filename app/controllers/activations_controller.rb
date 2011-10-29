# encoding: utf-8
class ActivationsController < ApplicationController
  before_filter :require_no_user

  def create
    #@user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
    #raise Exception if @user.active?
    #
    #if @user.activate!
    #  flash[:notice] = "Your account has been activated!"
    #  UserSession.create(@user, false) # Log user in manually
    #  @user.deliver_welcome!
    #  redirect_to user_path(@user)
    #else
    #  render :text => "new #{puts @user}"
    #  #render :action => :new
    #end
    @user = User.find_using_perishable_token(params[:activation_code], 1.week)
    if @user && @user.activate!
      flash[:success] = "你的帐号已经激活"
      UserSession.create(@user, false)
      redirect_to user_path(@user)
    else
      redirect_to root_path
    end
  end
end
