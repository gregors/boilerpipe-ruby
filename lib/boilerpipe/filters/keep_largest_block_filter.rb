# Keeps the largest TextBlock only (by the number of words). In case of
# more than one block with the same number of words, the first block is chosen.
# All discarded blocks are marked "not content" and flagged as :MIGHT_BE_CONTENT.
#
# Note that, by default, only TextBlocks marked as "content" are taken into
# consideration.

module Boilerpipe::Filters
  class KeepLargestBlockFilter
    def initialize(expand_to_same_level_text, min_words)
      @expand_to_same_level_text = expand_to_same_level_text
      @min_words = min_words
    end

    INSTANCE = KeepLargestBlockFilter.new(false, 0)
    INSTANCE_EXPAND_TO_SAME_TAGLEVEL = KeepLargestBlockFilter.new(true, 0)
    INSTANCE_EXPAND_TO_SAME_TAGLEVEL_MIN_WORDS = KeepLargestBlockFilter.new(true, 150)

    def process(doc)
      tbs = doc.text_blocks
      return false if tbs.size < 2

      # find tb with the most words
      largest_block = tbs.select(&:is_content?).max_by(&:num_words)
      level = @expand_to_same_level_text ? largest_block.tag_level : -1

      # set labels for text blocks
      tbs.each do |tb|
        if tb == largest_block
          tb.content = true
          tb.add_label :VERY_LIKELY_CONTENT
        else
          tb.content = false
          tb.add_label :MIGHT_BE_CONTENT
        end
      end

      n = tbs.index(largest_block)
      if @expand_to_same_level_text && n
        # expand blocks to the left
        expand_tag_level(tbs[0...n].reverse, level, @min_words)

        # expand blocks to the right
        expand_tag_level(tbs[n + 1..-1], level, @min_words)
      end
    end

    # sets content to true
    def expand_tag_level(tbs, level, min_words)
      tbs.each do |tb|
        if tb.tag_level < level
          break
        elsif tb.tag_level == level
          tb.content = true if tb.num_words >= min_words
        end
      end
    end
  end
end
