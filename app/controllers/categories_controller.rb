class CategoriesController < ApplicationController
before_action :require_admin,  except: [:index, :show]
before_action :set_category, only: %i[ show edit ]

  def new
    @category = Category.new
  end

  # POST /category
  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        flash[:notice] = "Category was successfully created"
        format.html { redirect_to category_url(@category) }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end


  def index
    @categories = Category.paginate(page: params[:page], per_page: 3)
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 2)
  end

  # GET /users/1/edit
  def edit
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

# Check if the user is admin, but first Check if the usr is logged in
  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "Only Admins can perform this action"
      redirect_to categories_path
    end
  end

  def set_category
    @category = Category.find(params[:id])
  end

end
