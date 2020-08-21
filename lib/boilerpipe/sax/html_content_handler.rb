module Boilerpipe::SAX
  class HTMLContentHandler < Nokogiri::XML::SAX::Document
    attr_reader :in_ignorable_element, :label_stacks, :last_start_tag

    attr_accessor :in_anchor_tag, :token_buffer, :font_size_stack
    ANCHOR_TEXT_START = "$\ue00a<"
    ANCHOR_TEXT_END = ">\ue00a$"

    def initialize
      @label_stacks = [[]]
      @tag_actions = ::Boilerpipe::SAX::TagActionMap.tag_actions
      @tag_level = 0
      @text_buffer = ''
      @token_buffer = ''
      @offset_blocks = 0
      @flush = false
      @block_tag_level = -1

      @in_body_tag = 0
      @in_anchor_tag = 0
      @in_ignorable_element = 0
      @in_anchor_text = false
      @font_size_stack = []
      @last_start_tag = ''
      @title
      @text_blocks = []
    end

    def start_element(name, attrs = [])
      @label_stacks << []
      tag = name.upcase.intern

      tag_action = @tag_actions[tag]
      if tag_action
        @tag_level += 1 if tag_action.changes_tag_level?
        @flush = tag_action.start(self, name, attrs) | @flush
      else
        @tag_level += 1
        @flush = true
      end

      @last_event = :START_TAG
      @last_start_tag = tag
    end

    def characters(text)
      flush_block if @flush

      return if in_ignorable_element?
      return if text.empty?

      # replace all whitespace with simple space
      text.gsub!(/\s+/, ' ')

      # trim whitespace
      started_with_whitespace = text =~ /^\s/
      ended_with_whitespace = text =~ /\s$/
      text.strip!

      #  add a single space if the block was only whitespace
      if text.empty?
        append_space
        return
      end

      # set block levels
      @block_tag_level = @tag_level if @block_tag_level == -1

      append_space if started_with_whitespace
      append_text(text)
      append_space if ended_with_whitespace

    end

    def end_element(name)
      tag = name.upcase.intern
      tag_action = @tag_actions[tag]
      if tag_action
        @flush = tag_action.end_tag(self, name) | @flush
      else
        @flush = true
      end

      @tag_level -= 1 if tag_action.nil? || tag_action.changes_tag_level?
      flush_block if @flush

      @last_event = :END_TAG
      @last_end_tag = tag
      @label_stacks.pop
    end

    def not_in_body_tag?
      @in_body_tag == 0
    end

    def flush_block
      @flush = false

      # set title
      if not_in_body_tag?
        @title = @token_buffer.strip if :TITLE == @last_start_tag
        clear_buffers
        return
      end

      # clear out if empty or just a space
      length = @token_buffer.size
      case length
      when 0
        return
      when 1
        clear_buffers if @last_event == :WHITESPACE
        return
      end

      num_words = 0
      num_words_current_line = 0
      num_words_in_wrapped_lines = 0
      num_wrapped_lines = 0
      num_linked_words = 0
      current_line_length = 0
      max_line_length = 80

      tokens = ::Boilerpipe::UnicodeTokenizer.tokenize(@token_buffer)
      tokens.each do |token|
        if ANCHOR_TEXT_START == token
          @in_anchor_text = true
        elsif ANCHOR_TEXT_END == token
          @in_anchor_text = false
        elsif is_word?(token)
          num_words += 1
          num_words_current_line += 1
          num_linked_words += 1 if @in_anchor_text
          token_length = token.size
          current_line_length += token_length + 1

          if current_line_length > max_line_length
            num_wrapped_lines += 1
            current_line_length = token_length
            num_words_current_line = 1
          end
        end
      end

      return if tokens.empty?

      num_words_in_wrapped_lines = 0
      if num_wrapped_lines == 0
        num_words_in_wrapped_lines = num_words
        num_wrapped_lines = 1
      else
        num_words_in_wrapped_lines = num_words - num_words_current_line
      end

      text_block = ::Boilerpipe::Document::TextBlock.new(@text_buffer.strip,
                                                         num_words,
                                                         num_linked_words,
                                                         num_words_in_wrapped_lines,
                                                         num_wrapped_lines,
                                                         @offset_blocks)

      @offset_blocks += 1
      clear_buffers
      text_block.set_tag_level(@block_tag_level)
      classify_text_block_with_labels(text_block)
      add_text_block(text_block)
      @block_tag_level = -1
    end

    def text_document
      flush_block
      ::Boilerpipe::Document::TextDocument.new(@title, @text_blocks)
    end

    def token_buffer_size
      @token_buffer.size
    end

    VALID_WORD_CHARACTER = /[\p{L}\p{Nd}\p{Nl}\p{No}]/
    # unicode regex - categories
    # \p{L}   -- Letter
    # \p{Nd}  -- a decimal digit
    # \p{Nl}  -- a letterlike numeric character
    # \p{No}  -- a numeric character of other type

    def is_word?(word)
      word =~ VALID_WORD_CHARACTER
    end

    def increase_in_ignorable_element!
      @in_ignorable_element += 1
    end

    # should we prevent less than zero here?
    def decrease_in_ignorable_element!
      @in_ignorable_element -= 1
    end

    def enter_body_tag!
      @in_body_tag += 1
    end

    def exit_body_tag!
      @in_body_tag -= 1
    end

    def in_ignorable_element?
      @in_ignorable_element > 0
    end

    def in_anchor_tag?
      @in_anchor_tag > 0
    end

    def classify_text_block_with_labels(text_block)
      @label_stacks
        .flatten
        .filter{|stack| stack}
        .each do |label_action|
          text_block.add_label(label_action.labels)
      end
    end

    def add_text_block(text_block)
      @text_blocks << text_block
    end

    # append space if last character wasn't already one
    def append_space
      return if @last_event == :WHITESPACE
      @last_event = :WHITESPACE

      @text_buffer << ' '
      @token_buffer << ' '
    end

    def append_text(text)
      @last_event = :CHARACTERS
      @text_buffer << text
      @token_buffer << text
    end

    def append_token(token)
      @token_buffer << token
    end

    def add_label_action(label_action)
      label_stack = @label_stacks.last
      label_stack << label_action
    end

    private

    def clear_buffers
      @token_buffer = ''
      @text_buffer = ''
    end
  end
end
