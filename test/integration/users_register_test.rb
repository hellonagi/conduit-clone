require 'test_helper'

class UsersRegisterTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get register_path
    assert_no_difference 'User.count' do
      post api_users_path, params: { user: { username: '',
                                             email: 'user@example.com',
                                             password: 'foo' } }
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
    assert_select   'div#error_explanation'
    assert_select   'div.field_with_errors'
  end

  test 'valid signup information' do
    assert_difference 'User.count', 1 do
      post api_users_path, params: { user: { username: 'example_user',
                                             email: 'user@example.com',
                                             password: 'password' } }
    end
    follow_redirect!
    assert_template 'users/show'
  end
end
