# Splits TextBlocks at paragraph boundaries.
#
# NOTE: This is not fully supported (i.e., it will break highlighting support via
# #getContainedTextElements()), but this one probably is necessary for some other filters.
#
# see MinClauseWordsFilter

module Boilerpipe::Filters
  class SplitParagraphBlocksFilter
    def self.process(doc)
      tbs = doc.text_blocks
      new_blocks = []
      changes = false
      tbs.each do |tb|
        paragraphs = tb.text.split(/[\n\r]+/)

        if paragraphs.size < 2
          new_blocks << tb
          next
        end

        is_content = tb.is_content?
        labels = tb.labels
        paragraphs.each do |paragraph|
          tbP = ::Boilerpipe::Document::TextBlock.new(paragraph)
          tbP.content = is_content
          tbP.add_labels(labels)
          new_blocks << tbP
          changes = true
        end
      end

      doc.replace_text_blocks!(new_blocks) if changes
      doc
    end
  end
end
