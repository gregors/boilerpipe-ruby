# encoding: utf-8

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
