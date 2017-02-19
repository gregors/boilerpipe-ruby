require 'spec_helper'

module Boilerpipe::SAX::TagActions
  describe BlockLevel do
    describe '#start' do
      it 'returns true' do
        expect(subject.start(nil, nil, nil)).to be true
      end
    end
    describe '#end_tag' do
      it 'returns true' do
        expect(subject.end_tag(nil, nil)).to be true
      end
    end
    describe '#changes_tag_level?' do
      it 'returns true' do
        expect(subject.changes_tag_level?).to be true
      end
    end
  end
end
