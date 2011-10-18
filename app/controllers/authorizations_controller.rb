class AuthorizationsController < ApplicationController
  before_filter :require_user, :only => [:destroy]

  def create
    omniauth = request.env['omniauth.auth']
    @auth = Authorization.find_from_hash(omniauth)
    @redirect_to = root_url
    @user = current_user
    if @user
      flash[:notice] = "#{@user.display_name}，你的帐号已经成功绑定到#{t('oauth.' + omniauth['provider'])}"
      @user.authorizations.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
      @redirect_to = user_path(@user)
    elsif @auth
      flash[:notice] = "欢迎回来，你正在使用#{t('oauth.' + omniauth['provider'])}登录绍兴活动网"
      UserSession.create(@auth.user, true)
      @redirect_to = user_path(@auth.user)
    else
      session[:omniauth] = omniauth
      @redirect_to = user_login_path
    end
    render :layout => false
  end
  
  def failure
    flash[:notice] = "Sorry, You din't authorize"
    redirect_to root_url
  end
  
  def blank
    render :text => "此页面不存在", :status => 404
  end

  def destroy
    @authorization = current_user.authorizations.find(params[:id])
    flash[:notice] = "Successfully deleted #{@authorization.provider} authentication."
    @authorization.destroy
    redirect_to edit_user_path(:current)
  end
end
