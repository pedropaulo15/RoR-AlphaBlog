class CategoriesController < ApplicationController
  
  before_action :required_admin, except: [:index, :show]
  
  def index
    # Adding pagination to the categories page
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category Created Successfully"
      redirect_to categories_path
    else
      render 'new'  
    end
  end
  
  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end
  
  # Grab the data from the form, where a new category is inserted.
  private 
  def category_params
    params.require(:category).permit(:name)
  end
  
  def required_admin
    if !logged_in? || (logged_in? and !current_user.admin?)
      flash[:danger] = "Only admins can perform that action"
      redirect_to categories_path
    end
  end
end