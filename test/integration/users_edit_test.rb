require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mike)
  end

  test 'unsuccessful edit' do
    log_in_as(@user)
    get settings_path
    assert_template 'users/edit'
    patch api_user_path, params: { user: { username: '',
                                           email: 'foo@invalid',
                                           image: '',
                                           bio: '',
                                           password: 'foo' } }
    assert_template 'users/edit'
    assert_select 'div.alert', 'The form contains 3 errors.'
  end

  test 'successful edit' do
    get settings_path
    log_in_as(@user)
    assert_redirected_to settings_url
    username = 'michael'
    email = 'foo@bar.com'
    patch api_user_path, params: { user: { username:,
                                           email:,
                                           image: 'https://imgur.com/N4VcUeJ',
                                           bio: 'This is bio.',
                                           password: '' } }
    assert_not flash.empty?
    assert_redirected_to profile_url(username)
    @user.reload
    assert_equal username, @user.username
    assert_equal email, @user.email
  end
end
