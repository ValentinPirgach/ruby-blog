class CategoriesController < ApplicationController
  before_action :require_admin, only: [:new, :create, :edit, :update]
  before_action :get_category, only: [:update, :edit, :show]

  def index
    @categories = Category.paginate(:page => params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params

    if @category.save
      flash[:success] = "Category was create successfully"
      redirect_to categories_path
    else
      render :new
    end
  end

  def show
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = "Category name was successfully updated"
      redirect_to category_path(@category)
    else
      render :edit
    end
  end

  private
    def get_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end

    def require_admin
      if !logged_in? || (logged_in? && !current_user.admin?)
        flash[:danger] = "Only admins can perform that action"
        redirect_to categories_path
      end
    end
end
