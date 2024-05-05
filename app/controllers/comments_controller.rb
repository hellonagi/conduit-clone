class CommentsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    @article = Article.find_by(slug: params[:slug])
    @comment.article = @article

    if @comment.save
      flash[:success] = 'Comment posted'
      redirect_to article_url(@article.slug)
    else
      flash[:danger] = 'Comment failed'
      redirect_to article_path(@article.slug)
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @article = @comment.article
    return unless @comment.user == current_user

    @comment.destroy
    flash[:success] = 'Comment deleted'
    if request.referrer.nil?
      redirect_to article_url(@article.slug), status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  private

  def comment_params
    params.permit(:body)
  end
end
