module Boilerpipe::Extractors
  class ArticleExtractor

    def self.process(doc)
      ::Boilerpipe::Filters::TerminatingBlocksFinder.process(doc)
      ::Boilerpipe::Filters::DocumentTitleMatchClassifier.new(doc.title).process(doc)
      doc.content
    end
  end
end
