class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :success

  # to get some details about the user who own the session
  # For optimization, first we review if the current user is available (||=)
  # This line allows to views use this method
  helper_method :current_user, :logged_in?
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Allows to get the user who owns the session
  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = "Tou must logged in to perform this action"
      redirect_to login_path
    end
  end

end
