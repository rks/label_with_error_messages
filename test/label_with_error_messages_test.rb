require File.join(File.dirname(__FILE__), "test_helper")
require File.join(File.dirname(__FILE__), "..", "lib", "label_with_error_messages")

class ToSentenceTest < ActionView::TestCase
  def test_monkeypatches_nil
    assert_nothing_raised do
      assert_equal "", nil.to_sentence
    end
  end

  def test_monkeypatches_string
    assert_nothing_raised do
      assert_equal "", "".to_sentence
    end
  end
end

class LabelWithErrorMessagesTest < ActionView::TestCase

end