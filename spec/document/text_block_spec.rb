require 'spec_helper'

module Boilerpipe
  describe Document::TextBlock do
    subject { Document::TextBlock.new 'hello' }
    describe '.new' do
      context 'with text input' do
        it 'sets text' do
          expect(subject.text).to eq 'hello'
        end

        it 'bit set of containedTextElements' 
        it 'number of words'
        it 'number of words in anchor text'
        it 'number of workds in wrapped lines'
        it 'number of wrapped lines'
        it 'offset blocks'
      end
    end

    describe '#merge_next' do
    end

    describe '#add_label' do
    end

    describe '#has_label' do
    end

    describe '#remove_label' do
    end

    describe '#is_content?' do
    end
    it ''
    it ''
  end
end
