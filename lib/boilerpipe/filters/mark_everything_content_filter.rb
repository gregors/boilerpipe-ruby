# Marks all blocks as content.

module Boilerpipe::Filters
  class MarkEverythingContentFilter
    def self.process(doc)
      doc.text_blocks.each do |tb|
        tb.content = true if tb.is_not_content?
      end
      doc
    end
  end
end
