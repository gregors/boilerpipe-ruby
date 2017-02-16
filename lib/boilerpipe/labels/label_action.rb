module Boilerpipe::Labels
  class LabelAction
    def initialize(labels)
      @labels = []
      @labels << labels
    end
  end

  def add_to(text_block)
    text_block.add_labels(@labels)
  end

  def to_s
    @lables.to_s
  end
end
