class CategoriesController < ApplicationController
  
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
    
  end
  
  # Grab the data from the form, where a new category is inserted.
  private def category_params
    params.require(:category).permit(:name)
  end
  
end