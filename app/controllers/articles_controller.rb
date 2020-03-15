class ArticlesController < ApplicationController
	before_action :set_article, only: [:edit, :update, :show, :destroy]
def new
	@article = Article.new
 end

 def show
  #@article = Article.find(params[:id])
 end



def index
  @articles = Article.all
end

 def edit
 	#@article = Article.find(params[:id])
end

def destroy
  #@article = Article.find(params[:id])
  @article.destroy
  flash[:notice] = "Article was deleted"
  redirect_to articles_path
end

def update
  #@article = Article.find(params[:id])
  if @article.update(article_params)
   flash[:notice] = "Article was updated"
   redirect_to article_path(@article)
  else
   flash[:notice] = "Article was not updated"
   render 'edit'
  end
end

def create
  #render plain: params[:article].inspect
  @article = Article.new(article_params)
  @article.user = current_user

  #@article.save
  if @article.save
   flash[:notice] = "Article was successfully created"
   redirect_to article_path(@article)
  else
   render 'new'
  end
  #redirect_to articles_show(@article)
 end

private
  def article_params
   params.require(:article).permit(:title, :description)
  end
def set_article
   @article = Article.find(params[:id])
end

end