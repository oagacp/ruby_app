class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        flash[:notice] = "Welcome to Ruby Blog #{@user.username}, you have successfully sign up."
        redirect_to articles_path
      else
        render :new
      end
    end
  end
end

private
  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :fname, :lname, :email, :password)
  end
