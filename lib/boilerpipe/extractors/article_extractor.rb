module Boilerpipe::Extractors
  class ArticleExtractor

    def self.process(doc)
      title = doc.title

      filters = ::Boilerpipe::Filters
      filters::TerminatingBlocksFinder.process doc
      filters::DocumentTitleMatchClassifier.new(title).process doc
      filters::NumWordsRulesClassifier.process doc
      filters::IgnoreBlocksAfterContentFilter.process doc
      filters::TrailingHeadlineToBoilerplateFilter.process doc
      filters::BlockProximityFusion::MAX_DISTANCE_1.process doc
      doc.content
    end
  end
end
