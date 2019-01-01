#
# Keeps only blocks that have at least one segment fragment ("clause") with at least k
# words (default: 5).
#
# NOTE: You might consider using the SplitParagraphBlocksFilter upstream.
#
# SplitParagraphBlocksFilter

module Boilerpipe::Filters
  class MinClauseWordsFilter
    def self.process(doc, min_words = 5)
      doc.text_blocks.each do |tb|
        next if tb.is_not_content?

        clause_delimiter = /[\p{L}\d \u00a0]+[\,.:;!?]+(?:[ \n\r]+|$)/
        tb.text.scan(clause_delimiter).each do |possible_clause|
          if is_clause? possible_clause
            break
          else
            tb.content = false
          end
        end
      end

      doc
    end

    def self.is_clause?(text, min_words = 5)
      return false if text.nil?

      whitespace = /[ \n\r]+/
      text.scan(whitespace).size >= min_words
    end
  end
end
