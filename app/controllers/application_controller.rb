class ApplicationController < ActionController::Base
  helper_method :current_user_session, :current_user, :current_site, :logged_in?
  protect_from_forgery

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def require_user
      unless current_user
        store_location
        flash[:notice] = "请先登录"
        respond_to do |format|
          format.html do
            redirect_to login_path
          end
          format.js { render :text => "document.location='#{login_path}'"}
        end
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "您必须退出才可以访问这个页面"
        redirect_to user_path(current_user)
      end
    end

    def store_location
      session[:return_to] = request.fullpath
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
  
    def find_current_site
      @current_site ||= Site.find_by_host(Settings.current_site)
    end

    def current_site
      find_current_site || Site.new
    end

    def get_oauth_user_image(oauth)
      provider = oauth["provider"]
      user_image = ""
      if provider == "qzone"
        user_image = oauth["user_info"]["urls"]["figureurl_1"]
      elsif provider == "tqq"
        user_image = oauth["user_info"]["image"] + "/50"
      else
        user_image = oauth["user_info"]["image"]
      end
      user_image
    end
  
    def logged_in?
      !!current_user
    end
end
