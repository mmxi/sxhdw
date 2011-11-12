# encoding: utf-8
class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create, :bind, :login]

  def new
    @user = current_site.users.new
  end

  def create
    @user = current_site.users.build(params[:user])
    if @user.save_without_session_maintenance
      @user.deliver_activation_instructions! # send activation email
      flash[:notice] = "确认信已经发到你的邮箱 #{@user.email} ，你需要点击邮件中的确认链接来完成注册。"
      redirect_to signup_path
    else
      flash[:error] = "注册失败，请检查您的输入是否正确"
      render :action => :new
    end
  end

  def show
    @user = User.find(params[:id].to_i)
  end
  
  def auth_callback
    auth = request.env["omniauth.auth"]
    redirect_to root_path if auth.blank?
    @auth = auth
  end

  def bind
    if session[:omniauth].blank?
      redirect_to root_path
    else
      @user = User.new(:nickname => session[:omniauth]["user_info"]["name"],
                       :face_url => get_oauth_user_image(session[:omniauth])
      )
      @user_session = UserSession.new()
      if request.post?
        @user_session = UserSession.new(params[:user_session])
        if @user_session.save
          @user = UserSession.find.user
          @new_auth = Authorization.create_from_hash(session[:omniauth], @user)
          flash[:success] = "欢迎#{t('oauth.' + session[:omniauth]['provider'])}用户，你的帐号绑定成功"
          session[:omniauth] = nil
          redirect_to user_path(@user)
        else
          flash[:error] = "绑定失败，请检查用户名和密码"
          redirect_to user_bind_path
        end
      end
    end
  end
  
  def login
    if session[:omniauth].blank?
      redirect_to root_path
    else
      @user = User.new(:nickname => session[:omniauth]['user_info']['name'],
                       :face_url => get_oauth_user_image(session[:omniauth])
      )
      if request.post?
        @rpassword = newpass(6)
        @user = User.new(params[:user])
        @user.password, @user.password_confirmation = @rpassword, @rpassword
        @user.face_url = get_oauth_user_image(session[:omniauth])
        @user.activate!
        if @user.save
          @new_auth = Authorization.create_from_hash(session[:omniauth], @user)
          UserSession.create(@new_auth.user, true)
          flash[:notice] = "欢迎#{t('oauth.' + session[:omniauth]['provider'])}用户，你的帐号创建成功"
          session[:omniauth] = nil
          redirect_to user_path(@user)
        else
          flash[:error] = "请检查你的输入是否正确，可能该帐号已经存在"
          redirect_to user_login_path
        end
      end
    end
  end
  
  def newpass( len )
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    ret = ""
    1.upto(len) { |i| ret << chars[rand(chars.size-1)] }
    ret
  end
end
