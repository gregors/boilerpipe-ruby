# encoding: utf-8
module Boilerpipe::Filters
  class ListAtEndFilter
    MAX = 9999999

    def process(doc)
      changes = false
      tag_level = MAX
      doc.text_blocks.each do |tb|
        if tb.is_content? && tb.has_label?(:VERY_LIKELY_CONTENT)
          tag_level = tb.tag_level
        elsif (tb.tag_level > tag_level && tb.has_label?(:MIGHT_BE_CONTENT) && tb.has_label?(:LI) && tb.link_density == 0)
          tb.content = true
          changes = true
        else
          tag_level = MAX
        end
      end
      changes
    end

  end
end
