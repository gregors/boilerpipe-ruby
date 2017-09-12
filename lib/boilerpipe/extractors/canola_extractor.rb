module Boilerpipe::Extractors
  class CanolaExtractor

    def self.text(contents)
      doc = ::Boilerpipe::SAX::BoilerpipeHTMLParser.parse(contents)
      ::Boilerpipe::Extractors::CanolaExtractor.process doc
      doc.content
    end

    def self.process(doc)
      ::Boilerpipe::Filters::CanolaClassifier.process doc

      doc
    end
  end
end
