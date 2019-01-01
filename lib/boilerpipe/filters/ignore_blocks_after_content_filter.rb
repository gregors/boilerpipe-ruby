# Marks all blocks as "non-content" that occur after blocks that have been
# marked INDICATES_END_OF_TEXT. These marks are ignored unless a minimum
# number of words in content blocks occur before this mark (default: 60).
# This can be used in conjunction with an upstream TerminatingBlocksFinder.

module Boilerpipe::Filters
  class IgnoreBlocksAfterContentFilter < HeuristicFilterBase
    def self.process(doc, min_num_words = 60)
      found_end_of_text = false
      num_words = 0

      doc.text_blocks.each do |tb|
        end_of_text = tb.has_label? :INDICATES_END_OF_TEXT
        num_words += num_full_text_words(tb) if tb.is_content?
        found_end_of_text = true if end_of_text && num_words >= min_num_words
        tb.content = false if found_end_of_text
      end

      doc
    end
  end
end
