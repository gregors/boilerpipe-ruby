module Boilerpipe::Extractors
  class LargestContentExtractor
    def self.text(contents)
      doc = ::Boilerpipe::SAX::BoilerpipeHTMLParser.parse(contents)
      ::Boilerpipe::Extractors::LargestContentExtractor.process doc
      doc.content
    end

    def self.process(doc)
      filters = ::Boilerpipe::Filters
      filters::NumWordsRulesClassifier.process doc
      filters::BlockProximityFusion::MAX_DISTANCE_1.process doc
      filters::KeepLargestBlockFilter::INSTANCE.process doc

      doc
    end
  end
end
