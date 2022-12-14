class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :require_user, Only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1 or /users/1.json
  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 2)
  end

  # GET /users/1/edit
  def edit
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 2)
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
        session[:user_id] = @user.id
        flash[:notice] = "Welcome to Ruby Blog #{@user.username}, you have successfully sign up."
        format.html { redirect_to user_url(@user) }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end

# DELETE /users/1 or /users/1.json
def destroy
  @user.destroy
  session[:user_id] = nil if @user == current_user
  respond_to do |format|
    flash[:notice] = "#{@user.username} was successfully deleted and all the articles associated"
    format.html { redirect_to articles_path }
    format.json { head :no_content }
  end
end

private
  # Set the user to do some action.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :fname, :lname, :email, :password)
  end

def require_same_user
  if current_user != @user && !current_user.admin?
    flash[:alert] = "You can only edit r delete your own account"
    redirect_to @user
  end
end
