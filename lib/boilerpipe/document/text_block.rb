module Boilerpipe
  module Document
    class TextBlock
      # EMPTY_END = TextBlock.new('', 0, 0, 0, 0, 999999999999999999999999999)

      attr_reader :text, :num_words, :num_words_in_wrapped_lines, :num_words_in_anchor_text,
                  :num_wrapped_lines, :offset_blocks_start, :offset_blocks_end, :text_density,
                  :link_density, :labels, :tag_level

      attr_accessor :content

      def initialize(text, num_words = 0, num_words_in_anchor_text = 0, num_words_in_wrapped_lines = 0, num_wrapped_lines = 1, offset_blocks = 0)
        @labels = Set.new
        @text = text
        @num_words = num_words
        @num_words_in_anchor_text = num_words_in_anchor_text
        @num_words_in_wrapped_lines = num_words_in_wrapped_lines
        @num_wrapped_lines = num_wrapped_lines
        @offset_blocks_start = offset_blocks
        @offset_blocks_end = offset_blocks
        @content = false
        @tag_level = 0

        init_densities
      end

      def self.empty_start
        new('', 0, 0, 0, 1, -1)
      end

      def set_tag_level(level)
        @tag_level = level
      end

      def is_content?
        @content
      end

      def is_not_content?
        !is_content?
      end

      def add_label(label)
        @labels << label
      end

      def add_labels(labels)
        labels.each do |label|
          add_label(label)
        end
      end

      def has_label?(label)
        @labels.include?(label)
      end

      def remove_label(label)
        @labels.delete(label)
      end

      def merge_next(other)
        @text = "#{@text}\n#{other.text}"
        @num_words += other.num_words
        @num_words_in_anchor_text += other.num_words_in_anchor_text
        @num_words_in_wrapped_lines += other.num_words_in_wrapped_lines
        @num_wrapped_lines += other.num_wrapped_lines
        @offset_blocks_start = [@offset_blocks_start, other.offset_blocks_start].min
        @offset_blocks_end = [@offset_blocks_end, other.offset_blocks_end].max
        @content |= other.is_content?
        @labels.merge(other.labels.clone)
        @tag_level = [@tag_level, other.tag_level].min

        init_densities
      end

      def to_s
        "[#{@offset_blocks_start}-#{@offset_blocks_end};tl=#{@tag_level}; nw=#{@num_words};nwl=#{@num_wrapped_lines};ld=#{@link_density}]\t#{is_content? ? 'CONTENT' : 'BOILERPLATE'},#{labels_to_s}\n#{text}"
      end

      def labels_to_s
        if @labels.empty?
          'null'
        else
          "[#{@labels.to_a.join(',')}]"
        end
      end

      def clone
        throw NotImplementedError
      end

      private

      def init_densities
        if @num_words_in_wrapped_lines == 0
          @num_words_in_wrapped_lines = @num_words
        end
        @text_density = @num_words_in_wrapped_lines / @num_wrapped_lines.to_f
        @link_density = @num_words == 0 ? 0.0 : @num_words_in_anchor_text / @num_words.to_f
      end
    end
  end
end
