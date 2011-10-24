class Setting::UsersController < ApplicationController
  before_filter :require_user
  layout "settings"

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:success] = "设置更新成功"
    else
      flash[:error] = "设置更新失败"
    end
    redirect_to edit_setting_account_path
  end
  
  def change_password
    @user = current_user
    if request.put?
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
      if (@user.password and @user.password_confirmation) && (@user.password == @user.password_confirmation)
        @user.update_attributes(params[:user])
        flash[:success] = "修改密码成功"
      else
        flash[:error] = "请检查密码，重新输入"
      end
      redirect_to change_password_setting_account_path
    end
  end
end
