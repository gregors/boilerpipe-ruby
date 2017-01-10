require 'nokogiri'
require 'set'

class Parser < Nokogiri::XML::SAX::Document

  def initialize
    @label = []
    @tag_actions = {}
    @tag_level = 0
    @sb_last_was_whitespace = false
    @current_contained_text_elements = Set.new
    @text_buff = ''
    @token_buff = ''
    @text_element_idx = 0
	end

  def start_element(name, attrs = [])
    puts "start element #{name}"
    @label << nil
    ta = @tag_actions[name]

    if ta.nil?
      @tag_level += 1
      @flush = true
		else
			@tag_level += 1 if ta.changes_tag_level
      @flush = ta.start(self, name, name, attrs) | @flush
		end

    @last_event = :START_TAG
    @last_start_tag = name
  end

  def characters(string)
    @text_element_idx += 1
    if @flush
      flush_block
    end

    return if @in_ignorable_element != 0
    return if string.length == 0

    # replace all whitespace with simple space
    string = string.gsub(/\s+/, ' ')

    # trim whitespace
    started_with_whitespace = string  =~ /^\s/
    ended_with_whitespace = string  =~ /\s$/
    string = string.strip

    #  add a single space if the block was only whitespace
    if string.size == 0
      append_space
      @last_event = :WHITESPACE
      return
    end

    # set block levels
    @block_tag_level = @tag_level if @block_tag_level == -1

    append_space if started_with_whitespace
    append_text(string)
    append_space if ended_with_whitespace

    @last_event = :CHARACTERS
    @current_contained_text_elements << text_element_idx
  end

  def end_element(name)
    puts "end element #{name}"
    ta = @tag_actions[name]

    if ta.nil?
      @flush = true
    else
      @flush = ta.end(self, name) | @flush
    end

    @tag_level -= 1 if ta || ta.changes_tag_level
    flush_block if @flush

    @last_event = :END_TAG
    @last_end_tag = name
    @label.pop
  end

  def flush_block
    @flush = false
    if in_body == 0
      title = @token_buff.strip if 'TITLE'.casecmp?(@last_start_tag)
      clear_buffers
      return
    end

    # clear out if empty  or just a space
    length = @token_buff.size
    case length
    when 0
      return
    when 1
      if @sb_last_was_whitespace
        clear_buffers
      end
      return
    end

    tokens = UnicodeTokenizer.tokenize(@token_buff)
    tokens.each do |token|
      if ANCHOR_TEXT_START == token
        @in_anchor_text = true
      elsif ANCHOR_TEXT_END == token
        @in_anchor_text = false
      elsif is_word?(token)
        num_tokens += 1
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
      else
        num_tokens += 1
      end
    end

    return if num_tokens == 0

    num_words_in_wrapped_lines = 0
    if num_wrapped_lines == 0
      num_words_in_wrapped_lines = num_words
      num_wrapped_lines = 1
    else
      num_words_in_wrapped_lines = num_words - num_words_current_line
    end

    text_block = TextBlock.new(@text_buff,
                               current_contained_text_elements,
                               num_words,
                               num_linked_words,
                               num_words_in_wrapped_lines,
                               num_wrapped_lines, offsetBlocks)

   current_contained_text_elements = Set.new # bitset?
   offset_blocks += 1
   clear_buffers
   text_block.set_tag_level(block_tag_level)
   add_text_block(text_block)
   @block_tag_level -= 1
  end

#public void flushBlock() {
#    int numWords = 0;
#    int numLinkedWords = 0;
#    int numWrappedLines = 0;
#    int currentLineLength = -1; // don't count the first space
#    final int maxLineLength = 80;
#    int numTokens = 0;
#    int numWordsCurrentLine = 0;
#}

  private

  def add_text_block(text_block)
  end

  # append space if last character wasn't already one
  def append_space
    return if @sb_last_was_whitespace
    @sb_last_was_whitespace = true

    @text_buff << ' '
    @token_buff << ' '
  end

  def append_text(string)
    @sb_last_was_whitespace = false
    @text_buff << string
    @token_buff <<  string
  end

  def clear_buffers
   @token_buff.clear
   @text_buff.clear
  end
end
