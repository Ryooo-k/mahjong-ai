# frozen_string_literal: true

class Honba
  attr_accessor :draw_count, :kan_count
  attr_reader :count

  LIVE_WALL_RANGE = (0..121)
  DEAD_WALL_RANGE = (122..135)
  DORA_INDICATOR_INDEX = 0
  URA_DORA_INDICATOR_INDEX = 5
  RINSHAN_INDEX = 10

  def initialize(tiles)
    @count = 0
    @draw_count = 0
    @kan_count = 0
    @tile_orders = tiles.shuffle
  end

  def name
    number_kanji = @count.to_s.tr('0123456789', '〇一二三四五六七八九')
    "#{number_kanji}本場"
  end

  def live_walls
    @tile_orders[LIVE_WALL_RANGE]
  end

  def dead_walls
    @tile_orders[DEAD_WALL_RANGE]
  end

  def dora_indicators
    range = (DORA_INDICATOR_INDEX..@kan_count)
    dead_walls[range]
  end

  def ura_dora_indicators
    end_index = URA_DORA_INDICATOR_INDEX + @kan_count
    range = (URA_DORA_INDICATOR_INDEX..end_index)
    dead_walls[range]
  end

  def rinshan_tile
    target = RINSHAN_INDEX + @kan_count
    dead_walls[target]
  end

  def top_tile
    live_walls[@draw_count]
  end

  def remaining_live_wall_count
    live_walls[(@draw_count..)].size
  end

  def advance
    @count += 1
    @draw_count = 0
    @kan_count = 0
    @tile_orders = @tile_orders.shuffle
  end

  def reset
    @count = 0
    @draw_count = 0
    @kan_count = 0
    @tile_orders = @tile_orders.shuffle
  end
end
