module Boilerpipe::Extractors
  class NumWordsRulesExtractor
    def self.text(contents)
      doc = ::Boilerpipe::SAX::BoilerpipeHTMLParser.parse(contents)
      ::Boilerpipe::Extractors::NumWordsRulesExtractor.process doc
      doc.content
    end

    def self.process(doc)
      ::Boilerpipe::Filters::NumWordsRulesClassifier.process doc
      doc
    end
  end
end
