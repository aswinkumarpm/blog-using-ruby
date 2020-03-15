class CommentsController < ApplicationController

	 def new
    @comment = Comment.new
  end

	def create
	#render plain: params[:comment].inspect


	@article = Article.find(params[:article_id])
	@comment = @article.comments.create(params[:comment].permit(:name, :comment))
	@comment.user = current_user
	if @comment.save
   		redirect_to articles_path
  	else
    	flash.now[:danger] = "error"
  	end

	end

	def show
		# @article = Article.find(params[:article_id])
      @comments = Comment.find(params[:id])

	end

	def edit
		@comment = Comment.find(params[:id])
		@article = Article.find(params[:article_id])
	end

	def update
		@article = Article.find(params[:article_id])
        @comment = @article.comments.find(params[:id])
      if @comment.update(comment_params)
      	flash[:notice] = "comment was updated"
        redirect_to article_path(@article)
      else
        flash[:notice] = "comment was not updated"
        render 'edit'
    end

    end

	def destroy

		 @article = Article.find(params[:article_id])
      @comment = @article.comments.find(params[:id])
      @comment.destroy
   redirect_to articles_path
	end

	private 

    def comment_params
      params.require(:comment).permit(:body, :user_id, :article_id)
    end
end
