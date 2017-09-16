# A full-text extractor trained on http://krdwrd.org/
# https://krdwrd.org/trac/attachment/wiki/Corpora/Canola/CANOLA.pdf
# Works well with SimpleEstimator, too.

module Boilerpipe::Filters
  class CanolaClassifier

    def self.process(doc)
      return doc if doc.text_blocks.size < 1

      empty = Boilerpipe::Document::TextBlock.empty_start
      text_blocks = [empty] + doc.text_blocks + [empty]

      text_blocks.each_cons(3) do |slice|
        prev, current, nxt = *slice
        current.content = classify(prev, current, nxt)
      end

      doc
    end

    def self.classify(prev, current, nxt)
      current.link_density > 0 && nxt.num_words > 11 \
        || current.num_words > 19 \
        || nxt.num_words > 6 && nxt.link_density == 0 \
        && prev.link_density == 0 \
        && ( current.num_words > 6 || prev.num_words > 7 || nxt.num_words > 19 )
    end
  end
end
