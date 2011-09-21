class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create, :bind, :login]
  before_filter :require_user, :only => [:show, :edit, :update]
  layout "home"

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end

  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
  
  def auth_callback
    auth = request.env["omniauth.auth"]
    redirect_to root_path if auth.blank?
    @auth = auth
  end
  
  def bind
    #no login with oauth redirect to root_url
    if session[:omniauth].blank?
      redirect_to root_url
    end
  end
  
  def login
    if session[:omniauth].blank?
      redirect_to root_url
    end
    
    if request.post?
      
      logger.debug "0000000000000000000000000000000000000000000000000000000"
    end
  end
end