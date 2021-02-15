require 'spec_helper'

module Boilerpipe::SAX::TagActions
  describe Body do
    describe '#start' do
      it 'increase in_body_tag count' do
        handler = Boilerpipe::SAX::HTMLContentHandler.new
        expect { subject.start(handler, nil, nil) }.to change { handler.instance_variable_get(:@in_body_tag) }.from(0).to(1)
      end

      it 'flushes block' do
        handler = Boilerpipe::SAX::HTMLContentHandler.new
        handler.instance_variable_set(:@text_buffer, 'stuff')
        subject.start(handler, nil, nil)
        expect(handler.instance_variable_get(:@text_buffer)).to eq ''
      end

      it 'returns false' do
        handler = Boilerpipe::SAX::HTMLContentHandler.new
        expect(subject.start(handler, nil, nil)).to eq false
      end
    end

    describe '#end_tag' do
      it 'decreases in_body_tag count' do
        handler = Boilerpipe::SAX::HTMLContentHandler.new
        handler.instance_variable_set(:@in_body_tag, 1)
        expect { subject.end_tag(handler, nil) }.to change { handler.instance_variable_get(:@in_body_tag) }.from(1).to(0)
      end

      it 'flushes block' do
        handler = Boilerpipe::SAX::HTMLContentHandler.new
        handler.instance_variable_set(:@text_buffer, 'stuff')
        subject.end_tag(handler, nil)
        expect(handler.instance_variable_get(:@text_buffer)).to eq ''
      end

      it 'returns false' do
        handler = Boilerpipe::SAX::HTMLContentHandler.new
        expect(subject.end_tag(handler, nil)).to eq false
      end
    end

    describe '#changes_tag_level?' do
      it 'returns true' do
        expect(subject.changes_tag_level?).to be true
      end
    end
  end
end
