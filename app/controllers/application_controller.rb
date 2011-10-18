class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user_session, :current_user, :current_site

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
        flash[:notice] = t("message.You must be logged in to access this page")
        redirect_to login_path
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = t("message.You must be logged out to access this page")
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
end
