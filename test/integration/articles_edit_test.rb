require 'test_helper'

class ArticlesEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mike)
    log_in_as(@user)
  end

  test 'unsuccessful edit' do
    @article = @user.articles.first
    patch patch_article_path(@article.slug), params: { article: { title: '' } }
    assert_template 'articles/edit'
    assert_select 'div.alert', 'The form contains 1 error.'
  end

  test 'successful edit' do
    @article = @user.articles.first
    title = 'updated title 1'
    description = 'updated desc 1'
    body = 'updated body 1'
    patch patch_article_path(@article.slug), params: { article: { title:, description:, body: } }
    assert_not flash.empty?
    assert_redirected_to article_url(@article.slug)
    @article.reload
    assert_equal title, @article.title
    assert_equal description, @article.description
  end
end
