module Boilerpipe::SAX::TagActions
  # Marks this tag the body element (this should usually only
  # be set for the <BODY> tag).
  class Body
    def start(handler, name, attrs)
      handler.flush_block
      handler.enter_body_tag!
      false
    end

    def end_tag(handler, name)
      handler.flush_block
      handler.exit_body_tag!
      false
    end

    def changes_tag_level?
      true
    end
  end
end
