module Boilerpipe::SAX::TagActions
  class IgnorableElement
    # Marks this tag as "ignorable", i.e. all its inner content is silently skipped.
    def start(handler, name, attrs)
      handler.increase_in_ignorable_element!
      true
    end

    def end_tag(handler, name)
      handler.decrease_in_ignorable_element!
      true
    end

    def changes_tag_level?
      true
    end
  end
end
