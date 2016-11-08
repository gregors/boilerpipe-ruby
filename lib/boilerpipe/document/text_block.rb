module Boilerpipe
  module Document
    class TextBlock
      attr_reader :text
      def initialize(text)
        @text = text
      end
    end
  end
end
