require 'nokogiri'
module Boilerpipe::SAX
  class BoilerpipeHTMLParser
    def self.parse(text)
      # nokogiri uses libxml for mri and nekohtml for jruby
      # mri doesn't remove &nbsp; when missing the semicolon
      text = text.gsub(/(&nbsp) /, '\1; ')

      # use nokogiri to fix any bad tags, errors - keep experimenting with this
      text = Nokogiri::HTML(text).to_html

      handler = HTMLContentHandler.new
      noko_parser = Nokogiri::HTML::SAX::Parser.new(handler)
      noko_parser.parse(text)
      handler.text_document
    end
  end
end
