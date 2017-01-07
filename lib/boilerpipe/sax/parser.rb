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
      @flush = false
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
      append_space if started_with_whitespace || ended_with_whitespace
      @last_event = :WHITESPACE
      return
    end

    append_space if started_with_whitespace

    # set block levels
    @block_tag_level = @tag_level if @block_tag_level == -1

    # add characters
    append_to_buffers(string)

    # add trailing space
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

    @tag_level -= 1if ta || ta.changes_tag_level
    flush_block if @flush

    @last_event = :END_TAG
    @last_end_tag = name
    @label.pop
  end

  def flush_block
  end

  private

  # append space if last character wasn't already one
  def append_space
    return if @sb_last_was_whitespace
    @sb_last_was_whitespace = true

    @text_buff << ' '
    @token_buff << ' '
  end

  def append_to_buffers(string)
    @sb_last_was_whitespace = false
    @text_buff << string
    @token_buff <<  string
  end
end
