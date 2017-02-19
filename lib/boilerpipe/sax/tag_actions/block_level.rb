module Boilerpipe::SAX::TagActions
     # Explicitly marks this tag a simple "block-level" element,
     # which always generates whitespace
  class BlockLevel
    def start(handler, name, attrs)
      true
    end

    def end_tag(handler, name)
      true
    end

    def changes_tag_level?
      true
    end
  end
end
