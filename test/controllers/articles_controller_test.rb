require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @article = articles(:orange)
  end

  test 'should redirect create when not logged in' do
    assert_no_difference 'Article.count' do
      post post_article_path, params: { article: { body: 'Lorem ipsum' } }
    end
    assert_redirected_to login_url
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'Article.count' do
      delete delete_article_path(@article)
    end
    assert_response :see_other
    assert_redirected_to login_url
  end
end
