module Boilerpipe::SAX::TagActions
  # Marks this tag a simple "inline" element, which neither generates whitespace, nor a new block.
  class InlineNoWhitespace
    def start(handler, name, attrs)
      false
    end

    def end_tag(handler, name)
      false
    end

    def changes_tag_level?
      false
    end
  end
end
