# encoding: utf-8
module Boilerpipe::Filters
  class ExpandTitleToContentFilter
     # Marks all TextBlocks "content" which are between the headline and the part that has
     # already been marked content, if they are marked MIGHT_BE_CONTENT.
     # This filter is quite specific to the news domain.

    def process(doc)
      changes = false
      i = 0
      title = -1
      content_start = -1

      # find first title and content tbs
      doc.text_blocks.each do |tb|
        title = i if found_first_title?(content_start, tb)
        content_start = i if found_first_content?(content_start, tb)
        i += 1
      end

      return false if no_title_with_subsequent_content?(content_start, title)

      doc.text_blocks.each do |tb|
        if tb.has_label?(:MIGHT_BE_CONTENT)
          tb.content = true
          changes = true
        end
      end

      changes
    end

    def found_first_title?(content_start, tb)
        content_start == -1 && tb.has_label?(:TITLE)
    end

    def found_first_content?(content_start, tb)
        content_start == -1 && tb.is_content?
    end

    def no_title_with_subsequent_content?(content_start, title)
      content_start <= title || title == -1
    end

  end
end
