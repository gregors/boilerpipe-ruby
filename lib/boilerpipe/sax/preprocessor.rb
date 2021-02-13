module Boilerpipe::SAX
  class Preprocessor
    def self.strip(text)
      # script bug - delete script tags
      text = text.gsub(/\<script.+?<\/script>/im, '')
      # nokogiri uses libxml for mri and nekohtml for jruby
      # mri doesn't remove &nbsp; when missing the semicolon
      text.gsub(/(&nbsp) /, '\1; ')
    end
  end
end
