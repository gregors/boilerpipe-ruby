module Boilerpipe::SAX::TagActions
  # Special TagAction for the <FONT> tag, which keeps track of
  # the absolute and relative font size.
  class Font
    FONT_SIZE = /([\+\-]?)([0-9])/

    def start(handler, name, attrs)
      m = FONT_SIZE.match attrs['size']
      if m
        rel = m[1]
        val = m[2].to_i # absolute
        size = rel.empty? ? val : relative(handler.font_size_stack, rel, val)
        handler.font_size_stack <<  size
      else
        handler.font_size_stack << nil
      end
      false
    end

    def end_tag(handler, name)
      handler.font_size_stack.pop
      false
    end

    def changes_tag_level?
      false
    end

    def relative(font_size_stack, rel, val)
      prev_size = font_size_stack.reverse_each.find{|s| s != nil}
      prev_size = 3 if prev_size.nil?

      if rel == '+'
        prev_size + val
      else
        prev_size - val
      end
    end
  end
end
