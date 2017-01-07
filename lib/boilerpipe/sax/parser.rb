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

    return if @in_ignoreable_element != 0
    return if string.length == 0

    start_whitespace = false
    endt_whitespace = false

    # replace all whitespace with simple space
    string = string.gsub(/\s+/, ' ')

    # trim whitespace
    start_whitespace = string  =~ /^\s/
    end_whitespace = string  =~ /\s$/
    string = string.strip

    #  append leading whitespace if previous wasn't already one
    if string.size == 0
      if startWhitespace || endWhitespace
        if ! @sb_last_was_whitespace
          @text_buff << ' '
          @token_buff << ' '
        end
        @sb_last_was_whitespace = true
      else
        @sb_last_was_whitespace = false
      end
      @last_event = :WHITESPACE
      return
    end

    if start_whitespace
      if ! @sb_last_was_whitespace
        @text_buff << ' '
        @token_buff << ' '
      end
    end

    # set block levels
    @block_tag_level = @tag_level if @block_tag_level == -1
    @text_buff << string
    @token_buff <<  string

    # add trailing space
    if end_whitespace
      @text_buff << ' '
      @token_buff << ' '
    end

    @sb_last_was_whitespace = end_whitespace
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
end
