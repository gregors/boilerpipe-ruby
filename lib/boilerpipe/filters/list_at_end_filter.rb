# Marks nested list-item blocks after the end of the main content as content.
#  Used downstream of keep_largest_block_filter.

module Boilerpipe::Filters
  class ListAtEndFilter
    MAX = 99999999

    def self.process(doc)
      tag_level = MAX

      doc.text_blocks.each do |tb|
        if tb.is_content? && tb.has_label?(:VERY_LIKELY_CONTENT)
          tag_level = tb.tag_level
        elsif tb.tag_level > tag_level && tb.has_label?(:MIGHT_BE_CONTENT) && tb.has_label?(:LI) && tb.link_density == 0
          tb.content = true
        else
          tag_level = MAX
        end
      end

      doc
    end
  end
end
