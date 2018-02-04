class ArticlesController < ApplicationController
  
  # Force the edit, update, show and delete actions to run the method 
  # set_article before they execute anything else.
  # The method will retun @article.find(params[:id]) line of code, which will 
  # grab the article regarding to the id that is being passed through the URL(Route)
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  # The require_user was created on application controller, so is accessible from any other 
  # controller. It returns the user object that is logged in (from session). It 
  # It gets the user before execute the crud actions, to make sure the user can only 
  # manage their own articles
  before_action :require_user, except: [:index, :show]
  # It prevents the users to access other user's articles through the url, and delete or edit it.
  # This reuqire_same_user was create down below that controller/class.
  before_action :require_same_user, only: [:edit, :destroy, :update]
  
  def index
    # @articles new instance variable is going to have all articles from the databse
    # The paginate method is used to insert pagination on the template
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  def new 
    @article = Article.new
  end
  
  def edit
    # @article = Article.find(params[:id])
  end
  
  def update
    # @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  def create 
    #debugger
    # Works like a console.log, to print the content from the form
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      # Display a message to the user if the message was created.
      flash[:success] = "Article was successfully created!"
      redirect_to article_path(@article)  
    else
      render 'new'
    end
  end
  
  def show 
    # @article = Article.find(params[:id])
  end
  
  def destroy
    # @article = Article.find(params[:id]) 
    @article.destroy
    flash[:danger] = "Article was successfully deleted."
    redirect_to articles_path
  end
  
    private def article_params
    params.require(:article).permit(:title, :description) 
  end
  
  private def set_article
    @article = Article.find(params[:id])
  end
  
  def require_same_user
    if current_user != @article.user
      flash[:danger] = "You can only edit or delete your own articles."
      redirect_to root_path
    end
  end
  
end