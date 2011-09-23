class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user_session, :current_user
  
  # Start of declaration_authorization-related code
  #before_filter :set_current_user

  private
    def current_user_session
      logger.debug "ApplicationController::current_user_session"
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      logger.debug "ApplicationController::current_user"
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def require_user
      logger.debug "ApplicationController::require_user"
      unless current_user
        store_location
        flash[:notice] = t("message.You must be logged in to access this page")
        #redirect_to new_user_session_path
        redirect_to "/login"
        return false
      end
    end

    def require_no_user
      logger.debug "ApplicationController::require_no_user"
      if current_user
        store_location
        flash[:notice] = t("message.You must be logged out to access this page")
        redirect_to account_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
  protected
    def permission_denied
      respond_to do |format|
        format.html { redirect_to '/404.html' }
        format.xml  { head :unauthorized }
        format.js   { head :unauthorized }
      end
    end
    
    # set_current_user sets the global current user for this request.  This
    # is used by model security that does not have access to the
    # controller#current_user method.  It is called as a before_filter.
    #def set_current_user
    #  Authorization.current_user = current_user
    #end
end
