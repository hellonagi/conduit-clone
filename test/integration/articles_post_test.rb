require 'test_helper'

class ArticlesPostTest < ActionDispatch::IntegrationTest
  test 'invalid article post information' do
    get editor_path
    assert_no_difference 'Article.count' do
      post api_articles_path, params: { article: { title: '',
                                                slug: '',
                                                description: 'This is description.',
                                                body: 'This is body.' } }
    end
    assert_response :unprocessable_entity
    assert_template 'articles/new'
    assert_select   'div#error_explanation'
    assert_select   'div.field_with_errors'
  end

  test 'valid article post information' do
    assert_difference 'Article.count', 1 do
      post api_articles_path, params: { article: { title: 'This is Title',
                                                slug: 'this-is-title',
                                                description: 'This is description.',
                                                body: 'This is body.' } }
    end
    follow_redirect!
    assert_template 'articles/show'
    assert_not flash.empty?
  end
end
