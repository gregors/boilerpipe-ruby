require 'nokogiri'

class Parser < Nokogiri::XML::SAX::Document

  def initialize
    @label = []
    @tag_actions = {}
    @tag_level = 0
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
