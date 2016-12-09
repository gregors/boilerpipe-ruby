require 'spec_helper'

module Boilerpipe::Filters
  describe TerminatingBlocksFinder do
    describe '#process' do
      it 'requires a text document'
      context 'the text is ending text' do
        it 'returns true' do
         doc = double('document') 
        end
        it 'sets a label on the document'
      end

      context 'the text is not ending text' do
        it 'returns false'
        it 'doesnt change the document'
      end
    end
  end
end
