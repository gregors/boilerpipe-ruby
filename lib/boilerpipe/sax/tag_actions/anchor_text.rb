module Boilerpipe::SAX::TagActions
  class AnchorText
    # Marks this tag as "anchor" (this should usually only be set for the <A> tag). Anchor tags may not be nested.
    # There is a bug in certain versions of NekoHTML which still allows nested tags. If boilerpipe
    #* encounters such nestings, a SAXException is thrown.
    def start(handler, name, attrs)
      if handler.in_anchor_tag?
        handler.in_anchor_tag += 1
        nested_achor_tag_error_recovering(handler, name)
        return
      else
        handler.in_anchor_tag += 1
      end

      append_anchor_text_start(handler) unless handler.in_ignorable_element?
      false
    end

    def end_tag(handler, name)
      handler.in_anchor_tag -= 1
      append_anchor_text_end(handler) unless handler.in_anchor_tag? || handler.in_ignorable_element?
      false
    end

    def changes_tag_level
      true
    end

    def append_anchor_text_start(handler)
      handler.append_space
      handler.append_token(Boilerpipe::SAX::HTMLContentHandler::ANCHOR_TEXT_START)
      handler.append_space
    end

    def append_anchor_text_end(handler)
      handler.append_space
      handler.append_token(Boilerpipe::SAX::HTMLContentHandler::ANCHOR_TEXT_END)
      handler.append_space
    end

    def nested_achor_tag_error_recovering(handler, name)
      # - dunno about nokogiri???????
      # as nested A elements are not allowed per specification, we
      # are probably reaching this branch due to a bug in the XML parser
      puts "Warning: SAX input contains nested A elements -- You have probably hit a bug in your HTML parser (e.g., NekoHTML bug #2909310). Please clean the HTML externally and feed it to boilerpipe again. Trying to recover somehow..."
      end_tag(handler, name)
    end
  end
end
