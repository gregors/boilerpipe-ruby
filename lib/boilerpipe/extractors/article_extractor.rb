module Boilerpipe::Extractors
  class ArticleExtractor
    def process(doc)
      raise NotImplementedError
    end
  end
end
