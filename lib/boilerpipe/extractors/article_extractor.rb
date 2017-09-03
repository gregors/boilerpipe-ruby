module Boilerpipe::Extractors
  class ArticleExtractor
    def self.process(doc)
      ::Boilerpipe::Filters::TerminatingBlocksFinder.process(doc)
    end
  end
end
