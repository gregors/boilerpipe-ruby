module Boilerpipe::SAX
  class CommonTagActions 
    class Chained
      def initialize(t1, t2)
        @t1 = t1
        @t2 = t2
      end

      def start(handler, name, attrs)
        @t1.start(handler, name, attrs) | @t2.start(handler, name, attrs)
      end

      def end(handler, name)
      @t1.end(handler, name) | @t2.end(handler, name)
    end

    def changes_tag_level
      @t1.changes_tag_level || @t2.changes_tag_level
    end
  end

  class IgnorableElement
    # Marks this tag as "ignorable", i.e. all its inner content is silently skipped.
    def start(handler, name, attrs)
      handler.increase_in_ignorable_element
      true
    end

    def end(handler, name)
    handler.decrease_in_ignorable_element
    true
  end

  def changes_tag_level
    true
  end
end

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
        end(handler, name)
      end

      if handler.inIgnorableElement == 0
        handler.addWhitespaceIfNecessary();
        handler.append_space
        handler.tokenBuffer.append(BoilerpipeHTMLContentHandler.ANCHOR_TEXT_START);
        handler.append_space
      end
      false
    end

  end

  end
end
