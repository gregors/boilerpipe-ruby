require 'spec_helper'

module Boilerpipe::SAX::TagActions
  describe Chained do
    let(:tag1) { double('tag1') }
    let(:tag2) { double('tag2') }

    let(:chainer) do
      Chained.new(tag1, tag2)
    end

    describe '.new' do
      it 'takes two other tag actions' do
        tag1 = double('tag1')
        tag2 = double('tag2')
        Chained.new(tag1, tag2)
      end
    end
    describe '#start' do
      it 'combines starts' do
        expect(tag1).to receive(:start)
        expect(tag2).to receive(:start)
        handler = double('handler')
        chainer.start(handler, nil, nil)
      end
    end

    describe '#end_tag' do
      it 'combines end_tags' do
        expect(tag1).to receive(:end_tag)
        expect(tag2).to receive(:end_tag)
        handler = double('handler')
        chainer.end_tag(handler, nil)
      end
    end

    describe '#changes_tag_level?' do
      it 'returns combined changes' do
        expect(tag1).to receive(:changes_tag_level?).and_return(false)
        expect(tag2).to receive(:changes_tag_level?).and_return(true)
        expect(chainer.changes_tag_level?).to be true
      end
    end
  end
end
