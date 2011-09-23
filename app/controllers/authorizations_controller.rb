class AuthorizationsController < ApplicationController
  before_filter :require_user, :only => [:destroy]
  

  def create
    omniauth = request.env['omniauth.auth'] #this is where you get all the data from your provider through omniauth
    @auth = Authorization.find_from_hash(omniauth)
    @redirect_to = root_url
    if current_user
      flash[:notice] = "Successfully added #{omniauth['provider']} authentication"
      current_user.authorizations.create(:provider => omniauth['provider'], :uid => omniauth['uid']) #Add an auth to existing user
    elsif @auth
      logger.debug "=========Authorizations create elsif ===================="
      flash[:notice] = "Welcome back #{omniauth['provider']} user"
      UserSession.create(@auth.user, true) #User is present. Login the user with his social account
    else
      session[:omniauth] = omniauth
      @redirect_to = "/user/login"
    end
  end
  
  def failure
    flash[:notice] = "Sorry, You din't authorize"
    redirect_to root_url
  end
  
  def blank
    render :text => "Not Found", :status => 404
  end

  def destroy
    @authorization = current_user.authorizations.find(params[:id])
    flash[:notice] = "Successfully deleted #{@authorization.provider} authentication."
    @authorization.destroy
    redirect_to edit_user_path(:current)
  end
end
