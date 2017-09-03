require 'spec_helper'

module Boilerpipe::SAX
  describe HTMLContentHandler do
    describe '.new' do
      it 'sets up tag actions'
      it 'initializes state'
    end

    describe '#start_element' do
    end

    describe '#characters' do
    end

    describe '#end_element' do
    end

    describe '#flush_block' do
    end

    describe '#text_document' do
    end

    describe '#token_buffer_size' do
    end

    describe '#is_word?' do
    end

    describe '#increase_in_ignorable_element!' do
    end

    describe '#decrease_in_ignorable_element!' do
    end

    describe '#increase_in_body!' do
    end

    describe '#decrease_in_body!' do
    end

    describe '#in_ignorable_element?' do
    end

    describe '#in_anchor_tag?' do
    end

    describe '#add_text_block' do
    end

    describe '#append_space' do
    end

    describe '#append_text' do
    end

    describe '#append_token' do
    end

    describe '#add_label_action' do
      context 'with a nil as the last element in the label stacks' do
        before { subject.start_element('boom') }

        it 'removes that nil' do
          expect(subject.label_stacks.first).to eq nil
          subject.add_label_action(:boom)
          expect(subject.label_stacks.first).to eq [:boom]
          expect(subject.label_stacks.size).to eq 1
        end
      end
    end


  end
end
