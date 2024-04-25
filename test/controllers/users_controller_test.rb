require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mike)
  end

  test 'should get new' do
    get register_path
    assert_response :success
  end

  test 'should redirect edit when not logged in' do
    get settings_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect update when not logged in' do
    patch api_user_path, params: { user: { username: @user.username,
                                           email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
