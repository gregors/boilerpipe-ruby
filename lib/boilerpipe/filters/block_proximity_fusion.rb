# Fuses adjacent blocks if their distance (in blocks) does not exceed a certain limit. This
# probably makes sense only in cases where an upstream filter already has removed some blocks.

module Boilerpipe::Filters
  class BlockProximityFusion
    def initialize(max_blocks_distance, content_only, same_tag_level_only)
      @max_blocks_distance = max_blocks_distance
      @content_only = content_only
      @same_tag_level_only = same_tag_level_only
    end

    MAX_DISTANCE_1 = BlockProximityFusion.new(1, false, false)
    MAX_DISTANCE_1_SAME_TAGLEVEL = BlockProximityFusion.new(1, false, true)
    MAX_DISTANCE_1_CONTENT_ONLY = BlockProximityFusion.new(1, true, false)
    MAX_DISTANCE_1_CONTENT_ONLY_SAME_TAGLEVEL = BlockProximityFusion.new(1, true, true)

    def process(doc)
      text_blocks = doc.text_blocks
      return false if text_blocks.size < 2

      prev_block = text_blocks.first
      return false if prev_block.nil?

      offset = text_blocks.index(prev_block) + 1
      blocks = text_blocks[offset..-1]

      blocks_to_remove = []

      blocks.each do |tb|
        if tb.is_not_content?
          prev_block = tb
          next
        end

        diff_blocks = tb.offset_blocks_start - prev_block.offset_blocks_end - 1
        if diff_blocks <= @max_blocks_distance
          ok = true
          ok = false if prev_block.is_not_content? && @content_only
          ok = false if ok && prev_block.tag_level != tb.tag_level && @same_tag_level_only

          if ok
            prev_block.merge_next(tb)
            blocks_to_remove << tb
          else
            prev_block = tb
          end
        end
      end
      doc.replace_text_blocks!(text_blocks - blocks_to_remove)
      doc
    end
  end
end
