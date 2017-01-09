module Boilerpipe
  module Document
    class TextBlock
      attr_reader :text
      def initialize(text)
        @text = text
      end

      def is_content?
        true
      end

      def is_noncontent?
        !is_content?
      end

      def to_s
#"[" + offsetBlocksStart + "-" + offsetBlocksEnd + ";tl=" + tagLevel + "; nw=" + numWords + ";nwl=" + numWrappedLines + ";ld=" + linkDensity + "]\t" + (isContent ? "CONTENT" : "boilerplate") + "," + labels + "\n" + getText();
        "[#{@offset_blocks_start}]-#{@offset_blocks_end};tl=#{@tag_level}; nw=#{@num_words};nwl=#{@num_wrapped_lines};ld#{@link_density}]\t#{is_content? ? 'CONTENT' : 'boilerplate'},#{@labels}\n#{text}"
      end
    end
  end
end
