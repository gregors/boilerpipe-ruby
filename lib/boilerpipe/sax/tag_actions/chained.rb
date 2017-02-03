module Boilerpipe::SAX::TagActions
  class Chained
    def initialize(t1, t2)
      @t1 = t1
      @t2 = t2
    end

    def start(handler, name, attrs)
      @t1.start(handler, name, attrs) | @t2.start(handler, name, attrs)
    end

    def end_tag(handler, name)
      @t1.end_tag(handler, name) | @t2.end_tag(handler, name)
    end

    def changes_tag_level
      @t1.changes_tag_level || @t2.changes_tag_level
    end
  end
end
