class ArticlesController < ApplicationController
  
  def index
    # @articles new instance variable is going to have all articles from the databse
    @articles = Article.all
  end
  
  def new 
    @article = Article.new
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
    
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
  
  private def article_params
    params.require(:article).permit(:title, :description) 
  end
  
  def show 
    @article = Article.find(params[:id]);
  end
  
  
end