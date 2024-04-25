class ArticlesController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :correct_user,   only: :destroy

  def index
    @articles = Article.page(params[:page])
    @tags = Tag.limit(10)
  end

  def show
    @article = Article.includes(:tags).find_by(slug: params[:slug])
  end

  def new
    @article = current_user.articles.build if logged_in?
  end

  def edit
    @article = Article.find_by(slug: params[:slug])
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:success] = '投稿完了'
      redirect_to article_url(@article.slug)
    else
      @feed_items = current_user.feed.page(params[:page])
      render 'new', status: :unprocessable_entity
    end
  end

  def update; end

  def destroy
    @article.destroy
    flash[:success] = 'Article deleted'
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :body)
  end

  def correct_user
    @article = current_user.articles.find_by(slug: params[:slug])
    redirect_to root_url, status: :see_other if @article.nil?
  end
end
