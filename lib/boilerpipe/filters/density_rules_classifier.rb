# Classifies TextBlocks as content/not-content through rules that have been determined
# using the C4.8 machine learning algorithm, as described in the paper
# "Boilerplate Detection using Shallow Text Features", particularly using text densities and link
# densities.

module Boilerpipe::Filters
  class DensityRulesClassifier

    def self.process(doc)
      #return doc if doc.text_blocks.size < 2

      empty = Boilerpipe::Document::TextBlock.empty_start
      text_blocks = [empty] + doc.text_blocks + [empty]

      text_blocks.each_cons(3) do |slice|
        prev, current, nxt = *slice
        current.content = classify(prev, current, nxt)
      end

      doc
    end

    def self.classify(prev, current, nxt)
      return false if current.link_density > 0.333333

      if prev.link_density <= 0.555556
        if current.text_density <= 9
          return true if nxt.text_density > 10
          return prev.text_density <= 4 ? false : true
        else
          return nxt.text_density == 0 ? false : true
        end
      else
        return false if nxt.text_density <= 11
        true
      end
    end
  end
end
