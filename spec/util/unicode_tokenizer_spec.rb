require 'spec_helper'

module Boilerpipe
  describe UnicodeTokenizer do
    it 'tokenizes words' do
      input = 'How are you?'
      output = UnicodeTokenizer.tokenize(input)
      expect(output).to match_array(["How", "are", "you?"])
    end
  end
end
