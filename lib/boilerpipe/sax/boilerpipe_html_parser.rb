require 'nokogiri'
module Boilerpipe::SAX
  class BoilerpipeHTMLParser
    def self.parse(text)

      # use nokogiri to fix any bad tags, errors - keep experimenting with this
      text = Nokogiri::XML(text).to_xml

      handler = HTMLContentHandler.new
      noko_parser = Nokogiri::HTML::SAX::Parser.new(handler)
      noko_parser.parse(text)
      handler.text_document
    end
  end
end
