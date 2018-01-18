class ArticlesController < ApplicationController
  
  # Force the edit, update, show and delete actions to run the method 
  # set_article before they execute anything else.
  # The method will retun @article.find(params[:id]) line of code, which will 
  # grab the article regarding to the id that is being passed through the URL(Route)
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  
  def index
    # @articles new instance variable is going to have all articles from the databse
    @articles = Article.all
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
      flash[:notice] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  def create 
    # Works like a console.log, to print the content from the form
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    if @article.save
      # Display a message to the user if the message was created.
      flash[:notice] = "Article was successfully created!"
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
    flash[:notice] = "Article was successfully deleted."
    redirect_to articles_path
  end
  
    private def article_params
    params.require(:article).permit(:title, :description) 
  end
  
  private def set_article
    @article = Article.find(params[:id])
  end
  
end