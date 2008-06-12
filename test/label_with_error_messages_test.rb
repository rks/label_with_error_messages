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

module LabelAssertions
  def assert_label_text(expected, actual)
    assert_match(/<label([^>]*)>#{expected}<\/label>/, actual)
  end

  def assert_label_class(expected, actual)
    assert_match(/<label([^>]*)class="#{expected}"([^>]*)>([^<]+<\/label>)/, actual)
  end
end

class LabelWithErrorMessagesTest < ActionView::TestCase
  include LabelAssertions

  def setup
    @errors = stub :on => nil
    @person = stub :errors => @errors
  end

  def test_should_add_label_with_error_messages_to_chain
    # An ActionView::TestCase acts as the erb execution environment
    assert self.respond_to?(:label_without_error_messages)
  end

  def test_should_behave_normally_when_object_name_is_not_an_instance_variable
    assert_dom_equal %(<label for="organization_name">Name</label>), label(:organization, :name)
  end

  def test_should_ask_an_instance_variable_if_it_has_errors_on_the_attribute
    @errors.expects(:on).with(:name).returns(nil)
    label :person, :name
  end

  def test_should_not_alter_label_text_if_attribute_is_valid
    assert_label_text "Name", label(:person, :name)
  end

  def test_should_add_error_messages_to_text_if_attribute_is_not_valid
    @errors.stubs(:on).with(:name).returns(["can't be blank"])
    assert_label_text "Name can't be blank", label(:person, :name)
  end

  def test_should_not_add_error_messages_if_text_is_explicity_set
    @errors.stubs(:on).with(:name).returns(["can't be blank"])
    assert_label_text "Nombre", label(:person, :name, "Nombre")
  end

  def test_should_join_two_errors_with_and
    @errors.stubs(:on).with(:name).returns(["has error one", "has error two"])
    assert_label_text "Name has error one and has error two", label(:person, :name)
  end

  def test_should_join_three_errors_with_commas
    @errors.stubs(:on).with(:name).returns(["has error one", "has error two", "has error three"])
    assert_label_text "Name has error one, has error two, and has error three", label(:person, :name)
  end

  def test_should_set_label_class_to_with_errors_when_no_class_is_set
    @errors.stubs(:on).with(:name).returns(["can't be blank"])
    assert_label_class "with_errors", label(:person, :name)
  end

  def test_should_append_with_errors_as_label_class_when_class_is_set
    @errors.stubs(:on).with(:name).returns(["can't be blank"])
    assert_label_class "required with_errors", label(:person, :name, nil, :class => "required")
  end
end