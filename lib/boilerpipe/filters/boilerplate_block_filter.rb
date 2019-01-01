# Removes TextBlocks which have explicitly been marked as "not content".

module Boilerpipe::Filters
  class BoilerplateBlockFilter
    def initialize(label)
      @label_to_keep = label
    end
    INSTANCE_KEEP_TITLE = BoilerplateBlockFilter.new(:TITLE)

    def process(doc)
      combined = doc.text_blocks.delete_if do |tb|
        if tb.is_not_content? &&
           (@label_to_keep.nil? || !tb.has_label?(:TITLE))
          true
        else
          false
        end
      end
      doc.replace_text_blocks!(combined)
      doc
    end
  end
end
