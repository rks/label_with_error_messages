module FancyViews
  module ToSentence
    def to_sentence; self.to_s; end
  end

  module LabelHelper
    def self.included(includer)
      includer.alias_method_chain :label, :error_messages
    end

    def label_with_error_messages(object_name, method, text = nil, options = {})
      model = instance_variable_get "@#{object_name}"
      if model && model.errors.on(method)
        text ||= method.to_s.humanize + " " + model.errors.on(method).to_sentence
        options[:class] = (options[:class] || "") << " with_errors"
        options[:class].strip!
      end
      label_without_error_messages(object_name, method, text, options)
    end
  end
end

[NilClass, String].each { |klass| klass.class_eval { include FancyViews::ToSentence } }
ActionView::Helpers::FormHelper.send :include, FancyViews::LabelHelper
