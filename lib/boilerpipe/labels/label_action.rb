module Boilerpipe::Labels
  class LabelAction
    attr_reader :labels

    def initialize(labels = [])
      @labels = labels
    end

    def add_to(text_block)
      text_block.add_labels(@labels)
    end

    def to_s
      @labels.join(',')
    end
  end
end
