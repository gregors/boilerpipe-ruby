# Marks all TextBlocks "content" which are between the headline and the part that has
# already been marked content, if they are marked MIGHT_BE_CONTENT.
# This filter is quite specific to the news domain.
# used downstream of KeepLargetBlockFilter since that's what sets MIGHT_BE_CONTENT

module Boilerpipe::Filters
  class ExpandTitleToContentFilter
    def self.process(doc)
      tbs = doc.text_blocks

      #     slower and more ruby-like
      #     comeback and let's do some benchmarking
      #     titles = tbs.select{ |tb| tb.has_label?(:TITLE) }
      #     title = tbs.index(titles.last)
      #     content_start = tbs.find_index(&:is_content?)

      i = 0
      title = nil
      content_start = nil

      tbs.each do |tb|
        title = i if content_start.nil? && tb.has_label?(:TITLE)
        content_start = i if content_start.nil? && tb.is_content?
        i += 1
      end

      return doc if no_title_with_subsequent_content?(content_start, title)

      tbs.slice(title...content_start).each do |tb|
        tb.content = true if tb.has_label?(:MIGHT_BE_CONTENT)
      end

      doc
    end

    def self.no_title_with_subsequent_content?(content_start, title)
      title.nil? || content_start.nil? || content_start <= title
    end
  end
end
