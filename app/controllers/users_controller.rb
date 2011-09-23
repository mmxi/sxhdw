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
      flash[:notice] = t("message.Account registered!")
      redirect_to root_url
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
  
  #bind account if user has a account
  def bind
    #no login with oauth redirect to root_url
    if session[:omniauth].blank?
      redirect_to root_url
      return
    end
    @user = User.new(:nickname => session[:omniauth]["user_info"]["name"])
    @user_session = UserSession.new()
    if request.post?
      @user_session = UserSession.new(params[:user_session])
      if @user_session.save
        #login success
        @user = (UserSession.find).user
        @new_auth = Authorization.create_from_hash(session[:omniauth], @user)
        if @new_auth
          flash[:success] = t("message.Successfully binded")
          redirect_to root_url
        else
          flash[:success] = t("message.Bind failed")
          redirect_to "/user/bind"
        end
      else
        flash[:error] = t("message.Login failed")
        redirect_to "/user/bind"
      end
    end
  end
  
  #bind account if user has no account
  def login
    if session[:omniauth].blank?
      redirect_to root_url
      return
    end
    @user = User.new(:nickname => session[:omniauth]["user_info"]["name"])
    @rpassword = newpass(6)
    if request.post?
      @user = User.new(params[:user])
      random_password = newpass(6)
      @user.password = random_password
      @user.password_confirmation = random_password
      if @user.save
        @new_auth = Authorization.create_from_hash(session[:omniauth], @user)
        #Log the authorizing user in.
        flash[:notice] = "Welcome #{@new_auth['provider']} user. Your account has been created."
        UserSession.create(@new_auth.user, true)
        redirect_to root_url
      else
        redirect_to "/user/login"
      end
    end
  end
  
  def newpass( len )
      chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      newpass = ""
      1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
      return newpass
  end
end