class ArticlesController < ApplicationController
  def home
    @articles = Article.includes(:tags).limit(5)
    @tags = Tag.limit(5)
  end

  def show
    @article = Article.includes(:tags).find_by(slug: params[:slug])
    if @article
      render 'articles/article'
    else
      render file: 'public/404.html', status: :not_found
    end
  end

  def editor; end

  def article; end
end
