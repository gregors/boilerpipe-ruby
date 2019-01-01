# A full-text extractor which extracts the largest text component of a page.
# For news articles, it may perform better than the DefaultExtractor, but
# usually worse than ArticleExtractor.

module Boilerpipe::Extractors
  class KeepEverythingWithKMinWordsExtractor
    def self.text(min, contents)
      doc = ::Boilerpipe::SAX::BoilerpipeHTMLParser.parse(contents)
      ::Boilerpipe::Extractors::KeepEverythingWithKMinWordsExtractor.process min, doc
      doc.content
    end

    def self.process(min, doc)
      ::Boilerpipe::Filters::SimpleBlockFusionProcessor.process doc
      ::Boilerpipe::Filters::MarkEverythingContentFilter.process doc
      ::Boilerpipe::Filters::MinWordsFilter.process min, doc
      doc
    end
  end
end
