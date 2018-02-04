class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # It makes the tow methods as helper method, which can me accessible from the views
  helper_method :current_user, :logged_in?
  
  # It return the user object from the DB, based on the user id that is set on the session
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  # It return a boolean
  def logged_in?
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action."
      redirect_to root_path
    end
  end
  
end
