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

  test 'should get new' do
    get editor_path
    assert_response :success
    assert_select 'title', "Editor — #{@base_title}"
  end
end
