class HTMLParser < Nokogiri::XML::SAX::Document
  @tag_actions = {}
  @labels = []
  @flush = false
  @last_start_tag
  @last_end_tag
  @lastEvent
  @tag_level = 0

  def start_element(name, attrs = [])
    @labels << nil

    tag_action = @tag_actions[name]
    if tag_action
      if tag_action.changes_tag_level?
        @tag_level += 1
      end
      @flush = tag-action.start(self, name, attrs) | @flush
    else
      @tag_level += 1
      @flush = true
    end

    @last_event = :event_start_tag
    @last_start_tag = name
  end

  def characters(string)
    # Any characters between the start and end element expected as a string
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

  def flush_block
    puts 'flush block'
  end

end

class BoilerpipeHTMLContentHandler
  @title

  ANCHOR_TEXT_START = "$\ue00a<"
  ANCHOR_TEXT_END = ">\ue00a$"

  @token_buffer = StringIO.new
  @text_buffer = StringIO.new

  @in_body = 0
  @in_anchor = 0
  @in_ignorable_element = 0

  @block_tag_level = -1

  @sb_last_was_whitespace = false
  @textElementIdx = 0;

  @text_blocks = []

  @offsetBlocks = 0;
  private BitSet currentContainedTextElements = new BitSet();

  @in_anchor_text = false

  @font_size_stack = []

  def recycle
    @token_buffer.setLength(0);
    textBuffer.setLength(0);

    @in_body = 0
    @in_anchor = 0
    @in_ignorable_element = 0
    @sb_last_was_whitespace = false
    @text_element_idx = 0

    textBlocks.clear();

    @lastStartTag = nil
    @lastEndTag = nil
    @lastEvent = nil

    @offsetBlocks = 0
    @currentContainedTextElements.clear();

    @flush = false
    @inAnchorText = false
  end


end
