require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'full title helper' do
    assert_equal 'Conduit', full_title
    assert_equal 'Home — Conduit', full_title('Home')
  end
end
