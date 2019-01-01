module Boilerpipe::Filters
  class HeuristicFilterBase
    def self.num_full_text_words(tb, min_text_density = 9.0)
      tb.text_density >= min_text_density ? tb.num_words : 0
    end
  end
end
