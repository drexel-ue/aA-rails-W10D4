class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    helper_method :current_user, :logged_in?

    private

    def login(user)
        session_token = user.reset_session_token!
    end

    def logout
        user.reset_session_token!
        session[:session_token] =  nil
        redirect_to new_session_url
    end

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        !!current_user
    end

    def require_login
        redirect_to new_session_url unless logged_in?
    end

end
