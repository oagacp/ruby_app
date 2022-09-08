class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1 or /users/1.json
  def show
    @articles = @user.articles
  end

  # GET /users/1/edit
  def edit
  end

  def update
  # PATCH/PUT /users/1 or /users/1.json
    respond_to do |format|
      if @user.update(user_params)
        flash[:notice] = "The profile was updated successfully."
        format.html{ redirect_to user_url(@user) }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # create /signup/1 or /users/1.json
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

# DELETE /users/1 or /users/1.json
def destroy
  @user.destroy

  respond_to do |format|
    flash[:notice] = "#{@user.username} was successfully destroyed."
    format.html { redirect_to articles_url }
    format.json { head :no_content }
  end
end






private

private
  # Set the user to do some action.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :fname, :lname, :email, :password)
  end
