module Boilerpipe::Extractors
  class ArticleExtractor
    def self.text(contents)
      doc = ::Boilerpipe::SAX::BoilerpipeHTMLParser.parse(contents)
      ::Boilerpipe::Extractors::ArticleExtractor.process(doc)
    end

    def self.process(doc)
      title = doc.title

      filters = ::Boilerpipe::Filters
      filters::TerminatingBlocksFinder.process doc
      filters::DocumentTitleMatchClassifier.new(title).process doc
      filters::NumWordsRulesClassifier.process doc
      filters::IgnoreBlocksAfterContentFilter.process doc
      filters::TrailingHeadlineToBoilerplateFilter.process doc
      filters::BlockProximityFusion::MAX_DISTANCE_1.process doc
      filters::BoilerplateBlockFilter::INSTANCE_KEEP_TITLE.process doc
      filters::BlockProximityFusion::MAX_DISTANCE_1_CONTENT_ONLY_SAME_TAGLEVEL.process doc

      doc.content
    end
  end
end
