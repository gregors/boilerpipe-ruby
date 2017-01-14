require 'nokogiri'
module Boilerpipe::SAX
  class BoilerpipeHTMLParser
    def self.parse(text)
      handler = HTMLContentHandler.new
      noko_parser = Nokogiri::HTML::SAX::Parser.new(handler)
      noko_parser.parse(text)
      handler.text_document
    end
  end
end
