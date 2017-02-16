module Boilerpipe::SAX
  class TagActionMap
    def self.tag_actions
      {
        STYLE: TagActions::IgnorableElement.new,
        SCRIPT: TagActions::IgnorableElement.new,
        OPTION: TagActions::IgnorableElement.new,
        OBJECT: TagActions::IgnorableElement.new,
        EMBED: TagActions::IgnorableElement.new,
        APPLET: TagActions::IgnorableElement.new,
        LINK: TagActions::IgnorableElement.new,

        A: TagActions::AnchorText.new,
        BODY: TagActions::Body.new,

        STRIKE: TagActions::InlineNoWhitespace.new,
        U: TagActions::InlineNoWhitespace.new,
        B: TagActions::InlineNoWhitespace.new,
        I: TagActions::InlineNoWhitespace.new,
        EM: TagActions::InlineNoWhitespace.new,
        STRONG: TagActions::InlineNoWhitespace.new,
        SPAN: TagActions::InlineNoWhitespace.new,

        # New in 1.1 (especially to improve extraction quality from Wikipedia etc.)
        SUP: TagActions::InlineNoWhitespace.new,

        # New in 1.2
        CODE: TagActions::InlineNoWhitespace.new,
        TT: TagActions::InlineNoWhitespace.new,
        SUB: TagActions::InlineNoWhitespace.new,
        VAR: TagActions::InlineNoWhitespace.new,

        ABBR: TagActions::InlineWhitespace.new,
        ACRONYM: TagActions::InlineWhitespace.new,
        FONT: TagActions::InlineNoWhitespace.new,

        # added in 1.1.1
        NOSCRIPT: TagActions::IgnorableElement.new,

        # New in 1.3
        LI: TagActions::BlockTagLabel.new(::Boilerpipe::Labels::LabelAction.new(:LI)),
        H1: TagActions::BlockTagLabel.new(::Boilerpipe::Labels::LabelAction.new([:H1, :HEADING])),
        H2: TagActions::BlockTagLabel.new(::Boilerpipe::Labels::LabelAction.new([:H2, :HEADING])),
        H3: TagActions::BlockTagLabel.new(::Boilerpipe::Labels::LabelAction.new([:H3, :HEADING]))
      }
    end
  end
end

