require 'spec_helper'

module Boilerpipe::SAX::TagActions
  describe IgnorableElement do
    describe '#start' do
      it 'increase in_anchor count'
    end

    describe '#end_tag' do
      it 'decreases in_anchor count'
    end
  end

  describe '#changes_tag_level?' do
    it 'returns true?'
  end
end
