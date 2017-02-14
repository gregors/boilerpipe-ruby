require 'spec_helper'

module Boilerpipe::SAX::TagActions
  describe InlineNoWhitespace do
    describe '#start' do
      it 'returns false' do
        expect(subject.start(nil, nil, nil)).to be false
      end
    end
    describe '#end_tag' do
      it 'returns false' do
        expect(subject.end_tag(nil, nil)).to be false
      end
    end
    describe '#changes_tag_level' do
      it 'returns false' do
        expect(subject.changes_tag_level).to be false
      end
    end
  end
end
