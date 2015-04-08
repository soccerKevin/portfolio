class CommentsController < ApplicationController
  
  def new
    @comment = Comment.new
  end

  def edit
  end 

  def update
  end

  def show
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.article, notice: 'Thank you for commenting'}
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @article = @comment.article
    if @comment.destroy
      redirect_to @article, notice: 'Comment has been deleted' 
    else
      redirect_to @article, notice: "Could not delete comment"
    end
  end

  private
    #incorrect parameter array
    def comment_params
      params.require(:comment).permit(:commenter_name, :content)
    end

end
