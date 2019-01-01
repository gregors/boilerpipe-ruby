# Merges two subsequent blocks if their text densities are equal.

module Boilerpipe::Filters
  class SimpleBlockFusionProcessor
    def self.process(doc)
      tbs = doc.text_blocks
      return doc if tbs.size < 2

      blocks_to_remove = []
      tb1 = tbs.first
      tbs.drop(1).each do |tb|
        if tb1.text_density == tb.text_density
          tb1.merge_next(tb)
          blocks_to_remove << tb
        else
          tb1 = tb
        end
      end

      doc.replace_text_blocks!(tbs - blocks_to_remove)
      doc
    end
  end
end
