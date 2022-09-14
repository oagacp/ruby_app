class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:notice] = "You logged in successfully"
      # to track the user's session status
      session[:user_id] = user.id
      redirect_to user
    else
      flash[:alert] = "There is something wrong with your email or password, try again"
      redirect_to login_path
    end
  end


  def destroy
    session[:user_id] = nil
    flash.now[:notice] = "Logged out successfully"
    redirect_to root_path
  end

end
