# A full-text extractor which is tuned towards extracting sentences from news articles.

module Boilerpipe::Extractors
  class ArticleSentenceExtractor
    def self.text(contents)
      doc = ::Boilerpipe::SAX::BoilerpipeHTMLParser.parse(contents)
      ::Boilerpipe::Extractors::ArticleSentenceExtractor.process(doc)
      doc.content
    end

    def self.process(doc)
      ::Boilerpipe::Extractors::ArticleExtractor.process doc
      ::Boilerpipe::Filters::SplitParagraphBlocksFilter.process doc
      ::Boilerpipe::Filters::MinClauseWordsFilter.process doc
    end
  end
end
