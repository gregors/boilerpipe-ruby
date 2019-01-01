#  Marks all blocks as content that:
#  are on the same tag-level as very likely main content
#  (usually the level of the largest  block)
#  have a significant number of words, currently: at least 100
#  Used downstream of KeepLargestBlockFilter

module Boilerpipe::Filters
  class LargeBlockSameTagLevelToContentFilter
    def self.process(doc)
      largest = doc.text_blocks.find do |tb|
        tb.is_content? && tb.has_label?(:VERY_LIKELY_CONTENT)
      end

      return doc if largest.nil?

      tag_level = largest.tag_level

      doc.text_blocks.each do |tb|
        next if tb.is_content?

        tb.content = true if tb.num_words >= 100 && tb.tag_level == tag_level
      end

      doc
    end
  end
end
