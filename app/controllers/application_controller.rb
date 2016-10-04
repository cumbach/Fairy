class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_housekeeper
  helper_method :logged_in?

  def current_housekeeper
    @current_housekeeper ||= Housekeeper.find_by(session_token: session[:session_token])
  end

  def login!(housekeeper)
    @current_housekeeper = housekeeper
    session[:session_token] = current_housekeeper.reset_session_token!
  end

  def logged_in?
    !current_housekeeper.nil?
  end

  def logout!
    current_housekeeper.reset_session_token!
    session[:session_token] = nil
  end

  
  def require_housekeeper
    redirect_to new_session_url unless current_housekeeper
  end

end
