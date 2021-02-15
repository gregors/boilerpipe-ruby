require 'spec_helper'

module Boilerpipe::SAX
  describe HTMLContentHandler do
    describe '.new' do
      it 'sets up tag actions'
      it 'initializes state'
    end

    describe '#start_element' do
      it 'saves the last tag element' do
        subject.start_element 'div'
        expect(subject.last_start_tag).to eq :DIV
      end

      it 'converts the tag name into a symbol' do
        subject.start_element 'title'
        expect(subject.last_start_tag).to eq :TITLE
      end
    end

    describe '#characters' do
    end

    describe '#end_element' do
    end

    describe '#flush_block' do
      it 'resets flush'
      it 'sets title with last text from TITLE tag'
      it 'clears out text_buffer'
      it 'clears out token_buffer'
      it 'determins line and word counts'
      it 'creates text block'
      it 'classifies text block with labels'
      it 'adds text block to document'
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

    describe '#enter_body_tag!' do
    end

    describe '#exit_body_tag!' do
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
      context 'with an array as the last element in the label stacks' do
        before { subject.start_element('boom') }

        it 'adds the label' do
          expect(subject.label_stacks.last).to eq []
          subject.add_label_action(:boom)
          expect(subject.label_stacks.last).to eq [:boom]
          expect(subject.label_stacks.size).to eq 2
        end
      end
    end
  end
end
