# Marks trailing headlines TextBlocks that have the label :#HEADING
# as boilerplate. Trailing means they are marked content and are
# below any other content block.

module Boilerpipe::Filters
  class TrailingHeadlineToBoilerplateFilter
    def self.process(doc)
      doc.text_blocks.each do |tb|
        next unless tb.is_content?

        if tb.has_label? :HEADING
          tb.content = false
        else
          break
        end
      end

      doc
    end
  end
end
