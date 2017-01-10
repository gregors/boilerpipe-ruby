module Boilerpipe::SAX
  class HTMLContentHandler < Nokogiri::XML::SAX::Document
    @tag_actions = {}
    @labels = []
    @flush = false
    @last_start_tag
    @last_end_tag
    @lastEvent
    @tag_level = 0

    @title

    ANCHOR_TEXT_START = "$\ue00a<"
    ANCHOR_TEXT_END = ">\ue00a$"

    @in_body = 0
    @in_anchor = 0
    @in_ignorable_element = 0

    @block_tag_level = -1

    @token_buffer = StringIO.new
    @text_buffer = StringIO.new

    def start_element(name, attrs = [])
      @labels << nil

      tag_action = @tag_actions[name]
      if tag_action
        if tag_action.changes_tag_level?
          @tag_level += 1
        end
        @flush = tag_action.start(self, name, attrs) | @flush
      else
        @tag_level += 1
        @flush = true
      end

      @last_event = :event_start_tag
      @last_start_tag = name
    end

    def end_element(name)
      tag_action = @tag_actions[name]
      if tag_action
        @flush = tag_action.end(self, name) | @flush
      else
        @flush = true
      end

      @tag_level -= 1 if tag_action.nil? || tag_action.changesTagLevel?
      flush_block if @flush
      @last_event = :event_tag_end
      @last_end_tag = name
      @labels.pop
    end

    def characters(text)
      @text_element_index += 1
      flush_block if @flush

      return if in_ignorable_element != 0
      return if text.empty?

      # make all whitespace spaces and trim
      text.gsub!(/\s+/, ' ').strip!

      if text.empty?
        unless sbLastWasWhitespace
          @textBuffer.append ' '
          @tokenBuffer.append ' '
        end
        @last_event = :event_whitespace
        return
      end

      # add leading space if started with a space

      @block_tag_level = @tag_level if @block_tag_level == -1

      @text_buffer.append text
      @token_buffer.append text

      # add trailing space if trailed with a space

      @last_event = :event_characters
      #currentContainedTextElements.set(textElementIdx)
    end

    def flush_block
      @flush = false
      puts 'flush block'
    end

  end
end

class BoilerpipeHTMLContentHandler

  @sb_last_was_whitespace = false
  @textElementIdx = 0;

  @text_blocks = []

  @offsetBlocks = 0;
  private BitSet currentContainedTextElements = new BitSet();

  @in_anchor_text = false

  @font_size_stack = []

  def recycle
    @token_buffer.setLength(0);
    @text_buffer.setLength(0);

    @in_body = 0
    @in_anchor = 0
    @in_ignorable_element = 0
    @sb_last_was_whitespace = false
    @text_element_idx = 0

    @textBlocks.clear();

    @lastStartTag = nil
    @lastEndTag = nil
    @lastEvent = nil

    @offsetBlocks = 0
    @currentContainedTextElements.clear();

    @flush = false
    @inAnchorText = false
  end

end
