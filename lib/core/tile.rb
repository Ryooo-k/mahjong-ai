# frozen_string_literal: true

require_relative 'tile_definitions'

class Tile
  attr_reader :id, :code, :name, :number, :suit

  MAX_TILE_ID = 135

  def initialize(id, is_red)
    raise ArgumentError, '無効なIDです。' unless (0..MAX_TILE_ID).to_a.include?(id)

    @id = id
    @code   = BASE_TILE_MAP[id][:code]
    @name   = BASE_TILE_MAP[id][:name]
    @number = BASE_TILE_MAP[id][:number]
    @suit   = BASE_TILE_MAP[id][:suit]
    @is_red = is_red
  end

  def red?
    @is_red
  end
end
