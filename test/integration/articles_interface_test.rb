require 'test_helper'

class ArticlesInterface < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mike)
    log_in_as(@user)
  end
end

class ArticlesInterfaceTest < ArticlesInterface
  test 'should paginate articles' do
    get root_path
    assert_select 'nav.pagination'
  end

  test 'should show errors but not create article on invalid submission' do
    assert_no_difference 'Article.count' do
      post post_article_path, params: { article: { slug: '' } }
    end
    assert_select 'div#error_explanation'
  end

  test 'should create a article on valid submission' do
    body = 'This article really ties the room together'
    assert_difference 'Article.count', 1 do
      post post_article_path, params: { article: { title: 'title', description: 'desc', body:, user_id: @user.id } }
    end
    @article = Article.first
    assert_redirected_to article_url(@article.slug)
    follow_redirect!
    assert_match body, response.body
  end

  test 'should have article delete links on own article page' do
    @article = @user.articles.first
    assert_not_nil @article
    get article_path(@article.slug)
    assert_select 'a.btn.btn-sm.btn-outline-danger', 'Delete Article'
  end

  test 'should be able to delete own article' do
    first_article = @user.articles.page(1).first
    assert_difference 'Article.count', -1 do
      delete delete_article_path(first_article.slug)
    end
  end

  test "should not have delete links on other user's article page" do
    other_user_article = users(:john).articles.page(1).first
    get article_path(other_user_article.slug)
    assert_select 'a.btn.btn-sm.btn-outline-danger', { text: 'Delete Article', count: 0 }
  end
end
