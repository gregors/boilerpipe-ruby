module Boilerpipe
  module Document
    class TextDocument
      attr_reader :text_blocks
      attr_accessor :title

      def initialize(title, text_blocks=[])
        @text_blocks = text_blocks
        @title = title
      end

      def content
        text(true, false)
      end

      def text(include_content, include_noncontent)
        s = ''
        @text_blocks.each do |text_block|
          case text_block.is_content?
          when true
            next unless include_content
            s << text_block.text
            s << '\n'
          when false
            next unless include_noncontent
           s << text_block.text
           s << '\n'
          end
        end
        s
      end

      def debug_s
        @text_blocks.map(&:to_s).join("\n")
      end

    end
  end
end
