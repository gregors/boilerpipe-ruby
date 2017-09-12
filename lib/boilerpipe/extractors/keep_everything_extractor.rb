 # Marks all blocks as content.

module Boilerpipe::Extractors
  class KeepEverythingExtractor
    def self.text(contents)
      doc = ::Boilerpipe::SAX::BoilerpipeHTMLParser.parse(contents)
      ::Boilerpipe::Extractors::KeepEverythingExtractor.process doc
      doc.content
    end

    def self.process(doc)
      ::Boilerpipe::Filters::MarkEverythingContentFilter.process doc
      doc
    end
  end
end
