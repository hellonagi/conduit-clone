class ArticlesController < ApplicationController
  def index
    @articles = Article.includes(:tags).limit(10)
    @tags = Tag.limit(10)
  end

  def show
    @article = Article.includes(:tags).find_by(slug: params[:slug])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = '投稿完了'
      redirect_to article_url(@article.slug)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :body)
  end
end
