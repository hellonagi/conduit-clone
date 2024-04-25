require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @user = users(:mike)
    @article = @user.articles.build(title: 'This is Title', description: 'a' * 100,
                                    body: 'a' * 200, user_id: @user.id)
  end

  test 'should be valid' do
    assert @article.valid?
  end

  test 'user id should be present' do
    @article.user_id = nil
    assert_not @article.valid?
  end

  test 'title should be present' do
    @article.title = '     '
    assert_not @article.valid?
  end

  test 'description should be present' do
    @article.description = '     '
    assert_not @article.valid?
  end

  test 'body should be present' do
    @article.body = '     '
    assert_not @article.valid?
  end

  test 'title should not be too long' do
    @article.title = 'a' * 33
    assert_not @article.valid?
  end

  test 'description should not be too long' do
    @article.description = 'a' * 129
    assert_not @article.valid?
  end

  test 'body should not be too long' do
    @article.body = 'a' * 1029
    assert_not @article.valid?
  end

  test 'order should be most recent first' do
    assert_equal articles(:most_recent), Article.first
  end
end
