module FancyViews
  module ToSentence
    def to_sentence; self.to_s; end
  end

  module LabelHelper
    def label_with_error_messages
      #
    end
  end
end

[NilClass, String].each { |klass| klass.class_eval { include FancyViews::ToSentence } }