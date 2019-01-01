# Keeps only those content blocks which contain at least k words.

module Boilerpipe::Filters
  class MinWordsFilter
    def self.process(min_words, doc)
      doc.text_blocks.each do |tb|
        next if tb.is_not_content?

        tb.content = false if tb.num_words < min_words
      end
      doc
    end
  end
end
