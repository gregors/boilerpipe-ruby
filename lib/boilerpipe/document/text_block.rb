module Boilerpipe
  module Document
    class TextBlock
      attr_reader :text
      def initialize(text, contained_text_elements=nil, num_words=0, num_words_in_anchor_text=0, num_words_in_wrapped_lines=0, num_wrapped_lines=0, offset_blocks=0)
        @text = text
        @contained_text_elements = contained_text_elements
        @num_words = num_words
        @num_words_in_anchor_texta = num_words_in_anchor_text
        @num_words_in_wrapped_lines = num_words_in_wrapped_lines
        @num_wrapped_lines = num_wrapped_lines
        @offset_blocks_start = offset_blocks
        @offset_blocks_end = offset_blocks
        init_densities
      end

      def is_content?
        true
      end

      def is_noncontent?
        !is_content?
      end

      def merge_next(other)
        @text = "#{@text}\n#{other}"
        @num_words += other.num_words
        @num_words_in_anchor_text += other.num_words_in_anchor_text
        @num_words_in_wrapped_lines += other.num_words_in_wrapped_lines
        @num_wrapped_lines += other.num_wrapped_lines
        @offset_blocks_start = [@offset_blocks_start , other.offset_blocks_start].min
        @offset_blocks_end = [@offset_blocks_end , other.offset_blocks_end].max
        init_densities
        #this.isContent |= other.isContent;   ????

        if @contained_text_elements.nil?
          @contained_text_elements = other.contained_text_elements.clone
        else
          @contained_text_elements.or(other.contained_text_elements)
        end
        @null_full_text_words += other.num_full_text_words

        if other.labels
          if @labels.nil?
            @labels = other.lables.clone
          else
            @labels.merge(other.lables.clone)
          end
        end

        @tag_level = [@tag_level, other.tag_level].min
      end

      def to_s
        #"[" + offsetBlocksStart + "-" + offsetBlocksEnd + ";tl=" + tagLevel + "; nw=" + numWords + ";nwl=" + numWrappedLines + ";ld=" + linkDensity + "]\t" + (isContent ? "CONTENT" : "boilerplate") + "," + labels + "\n" + getText();
        "[#{@offset_blocks_start}]-#{@offset_blocks_end};tl=#{@tag_level}; nw=#{@num_words};nwl=#{@num_wrapped_lines};ld#{@link_density}]\t#{is_content? ? 'CONTENT' : 'boilerplate'},#{@labels}\n#{text}"
      end

      private
      def init_densities
        if @num_words_in_wrapped_lines == 0
          @num_words_in_wrapped_lines = @num_words
          @num_wrapped_lines = 1
        end
        @text_density = @num_words_in_wrapped_lines / @num_wrapped_lines
        @link_density = @num_words == 0 ? 0 : @num_words_in_anchor_text / @num_words
      end
    end
  end
end
