module Boilerpipe::SAX::TagActions
  # for inline elements, which triggers some LabelAction on the
  # generated TextBlock.
  class InlineTagLabel
    def initialize(label_action)
      @label_action = label_action
    end

    def start(handler, name, attrs)
      handler.append_space
      handler.add_label_action(@label_action)
      false
    end

    def end_tag(handler, name)
      handler.append_space
      false
    end

    def changes_tag_level?
      false
    end
  end
end
