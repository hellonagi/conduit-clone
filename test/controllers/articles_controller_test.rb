require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = 'Conduit'
  end

  test 'should get root' do
    get root_path
    assert_response :success
    assert_select 'title', "Home — #{@base_title}"
  end

  test 'should get editor' do
    get editor_path
    assert_response :success
    assert_select 'title', "Editor — #{@base_title}"
  end

  test 'should get article' do
    get article_path
    assert_response :success
    assert_select 'title', "Article — #{@base_title}"
  end
end
