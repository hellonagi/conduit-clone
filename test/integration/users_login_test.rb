require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mike)
  end

  test 'login with invalid information' do
    get login_path
    assert_template 'sessions/new'
    post api_users_login_path, params: { session: { email: '', password: '' } }
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'login with valid email/invalid password' do
    get login_path
    assert_template 'sessions/new'
    post api_users_login_path, params: { session: { email: @user.email,
                                                    password: 'invalid' } }
    assert_not is_logged_in?
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'login with valid information followed by logout' do
    post api_users_login_path, params: { session: { email: @user.email,
                                                    password: 'password' } }
    assert is_logged_in?
    assert_redirected_to profile_url(@user.username)
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', root_path
    assert_select 'a[href=?]', editor_path
    assert_select 'a[href=?]', profile_path(@user.username)
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', register_path, count: 0
    delete api_users_logout_path
    assert_not is_logged_in?
    assert_response :see_other
    assert_redirected_to root_url
    follow_redirect!
    assert_select 'a[href=?]', root_path
    assert_select 'a[href=?]', editor_path, count: 0
    assert_select 'a[href=?]', profile_path(@user.username), count: 0
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', register_path
  end
end
