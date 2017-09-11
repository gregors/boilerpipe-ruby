module Boilerpipe::Extractors
  class DefaultExtractor

    def self.text(contents)
      doc = ::Boilerpipe::SAX::BoilerpipeHTMLParser.parse(contents)
      ::Boilerpipe::Extractors::DefaultExtractor.process doc
      doc.content
    end

    def self.process(doc)
      filters = ::Boilerpipe::Filters
      # merge adjacent blocks with equal text_density
      filters::SimpleBlockFusionProcessor.process doc

      # merge text blocks next to each other
      filters::BlockProximityFusion::MAX_DISTANCE_1.process doc

      # marks text blocks as content / non-content using boilerpipe alg
      filters::DensityRulesClassifier.process doc

      doc
    end
  end
end
