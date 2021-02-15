# Marks all TextBlocks "content" which are between the headline and the part that has
# already been marked content, if they are marked MIGHT_BE_CONTENT.
# This filter is quite specific to the news domain.
# used downstream of KeepLargetBlockFilter since that's what sets MIGHT_BE_CONTENT

module Boilerpipe::Filters
  class ExpandTitleToContentFilter
    def self.process(doc)
      tbs = doc.text_blocks

      title = tbs.select{ |tb| tb.has_label?(:TITLE) }.last
      title_idx = tbs.index(title)

      content_start = tbs.find_index(&:is_content?)

      return doc if no_title_with_subsequent_content?(content_start, title_idx)

      tbs.slice(title_idx...content_start)
        .select{ |tb| tb.has_label?(:MIGHT_BE_CONTENT) }
        .each{ |tb| tb.content = true }

      doc
    end

    def self.no_title_with_subsequent_content?(content_start, title_idx)
      # title has to start before content
      title_idx.nil? || content_start.nil? || title_idx >= content_start
    end
  end
end
