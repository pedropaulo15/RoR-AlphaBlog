class ArticlesController < ApplicationController
  def new 
    @article = Article.new
  end
  
  def create 
    # Works like a console.log, to print the content from the form
    render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.save
    redirect_to articles_show(@article)
  end
  
  private def article_params
    params.require(:article).permit(:title, :description) 
  end
  
  
end