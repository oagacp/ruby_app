module ApplicationHelper

  # Allows to get the user who owns the session
  def logged_in?
    !!current_user
  end




end
