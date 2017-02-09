module Boilerpipe::SAX::TagActions
  class InlineWhitespace
    def start(handler, name, attrs)
      handler.append_space
      false
    end

    def end_tag(handler, name)
      handler.append_space
      false
    end

    def changes_tag_level
      false
    end
  end
end
