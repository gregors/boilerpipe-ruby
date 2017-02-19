module Boilerpipe::SAX::TagActions
# for block-level elements, which triggers some LabelAction on
# the generated TextBlock.
  class BlockTagLabel
    def initialize(label_action)
      @label_action = label_action
    end

    def start(handler, name, attrs)
      handler.add_label_action(@label_action)
      true
    end

    def end_tag(handler, name)
      true
    end

    def changes_tag_level?
      true
    end
  end
end
