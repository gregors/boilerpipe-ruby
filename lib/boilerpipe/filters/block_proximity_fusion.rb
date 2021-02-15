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

      prev_block = if @content_only
                     text_blocks.find { |tb| tb.is_content? }
                   else
                     text_blocks.first
                   end

      return false if prev_block.nil?

      offset = text_blocks.index(prev_block) + 1
      blocks = text_blocks[offset..-1]

      blocks_to_remove = []

      blocks.each do |tb|
        if tb.is_not_content?
          prev_block = tb
          next
        end

        block_distance = tb.offset_blocks_start - prev_block.offset_blocks_end - 1

        ok = block_distance <= @max_blocks_distance
        ok = false if ok && @content_only && prev_block.is_not_content?
        ok = false if ok && @same_tag_level_only && prev_block.tag_level != tb.tag_level

        if ok
          prev_block.merge_next(tb)
          blocks_to_remove << tb
        else
          prev_block = tb
        end
      end

      doc.replace_text_blocks!(text_blocks - blocks_to_remove)
      doc
    end
  end
end
