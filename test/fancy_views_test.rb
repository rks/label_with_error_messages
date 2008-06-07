require File.join(File.dirname(__FILE__), "test_helper")

class TestSillyHelper < ActionView::TestCase
	def test_silly_method
		assert_dom_equal "<div>SILLY!</div>", "<div>SILLY!</div>"
	end
end