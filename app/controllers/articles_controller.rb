class ArticlesController < ApplicationController
  before_action :logged_in_user, only: %i[new edit create update destroy]
  before_action :correct_user,   only: %i[edit update destroy]

  def index
    @articles = Article.page(params[:page])
    @tags = Tag.limit(10)
  end

  def show
    @article = Article.find_by(slug: params[:slug])
    @comments = @article.comments
  end

  def new
    @article = current_user.articles.build if logged_in?
  end

  def edit
    @article = Article.find_by(slug: params[:slug])
  end

  def create
    @article = current_user.articles.build(article_params)
    tag_list = params[:article][:tag_list]
    if @article.save
      if tag_list.present?
        tags = tag_list.split(',').map(&:strip).uniq
        create_or_update_article_tags(@article, tags)
      end
      flash[:success] = 'Article posted'
      redirect_to article_url(@article.slug)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    tag_list = params[:article][:tag_list]
    if @article.update(article_params)
      if tag_list.present?
        tags = tag_list.split(',').map(&:strip).uniq
        create_or_update_article_tags(@article, tags)
      end
      flash[:success] = 'Article updated'
      redirect_to article_url(@article.slug)
    else
      render 'edit', status: :unprocessable_entity
    end
  end

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

  def create_or_update_article_tags(article, tags)
    article.tags.destroy_all

    tags.each do |tag|
      tag = Tag.find_or_create_by(name: tag)
      article.tags << tag
    rescue ActiveRecord::RecordInvalid
      false
    end
  end
end
