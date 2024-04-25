require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:mike)
  end

  test 'profile display' do
    log_in_as(@user)
    get profile_path(@user.username)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.username)
    assert_select 'h4', text: @user.username
    assert_select 'img.user-img'
    assert_match @user.articles.count.to_s, response.body
    assert_select 'nav.pagination'
    @user.articles.page(1).per(10) do |article|
      assert_match article.title, response.body
    end
  end
end
