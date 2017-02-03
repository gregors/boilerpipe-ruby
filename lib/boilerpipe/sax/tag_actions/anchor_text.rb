module Boilerpipe::SAX::TagActions
  class AnchorText
    # Marks this tag as "anchor" (this should usually only be set for the <A> tag). Anchor tags may not be nested.
   # There is a bug in certain versions of NekoHTML which still allows nested tags. If boilerpipe
   #* encounters such nestings, a SAXException is thrown.
    def start(handler, name, attrs)
      if handler.increase_in_ignorable_element > 0
        # - dunno about nokogiri???????
        # as nested A elements are not allowed per specification, we
        # are probably reaching this branch due to a bug in the XML parser
        puts "Warning: SAX input contains nested A elements -- You have probably hit a bug in your HTML parser (e.g., NekoHTML bug #2909310). Please clean the HTML externally and feed it to boilerpipe again. Trying to recover somehow..."
        end_tag(handler, name)
      end

      if handler.in_ignorable_element == 0
        handler.append_space
        handler.tokenBuffer.append(BoilerpipeHTMLContentHandler.ANCHOR_TEXT_START)
        handler.append_space
      end
      false
    end

    def end_tag(handler, name)
      if handler.decrease_in_anchor! == 0
        if handler.in_ignorable_element == 0
          handler.append_space
          handler.tokenBuffer.append(BoilerpipeHTMLContentHandler.ANCHOR_TEXT_END)
          handler.append_space
				end
			end
			false
		end

    def changes_tag_level
      true
    end
  end
end
