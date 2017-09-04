# encoding: utf-8

#  Classifies TextBlocks as content/not-content through rules that have been determined
#  using the C4.8 machine learning algorithm, as described in the paper
#  "Boilerplate Detection using Shallow Text Features" (WSDM 2010), particularly
#  using number of words per block and link density per block.

module Boilerpipe::Filters
  class NumWordsRulesClassifier

    def self.process(doc)
      empty = Boilerpipe::Document::TextBlock.empty_start
      text_blocks = [empty] + doc.text_blocks + [empty]

      text_blocks.each_cons(3) do |slice|
        prev, current, nxt = *slice
        current.content = classify(prev, current, nxt)
      end

      doc
    end

    private

    def self.classify(prev, current, nxt)
      return false if current.link_density > 0.333333

      if prev.link_density <= 0.555556
        return true if current.num_words > 16

        return true if nxt.num_words > 15
        return true if prev.num_words > 4
      else
        return true if current.num_words > 40
        return true if nxt.num_words > 17
      end

      false
    end

  end
end
