# frozen_string_literal: true

require_relative '../util/tile_definition'

class Tile
  attr_reader :id, :code, :name, :number
  attr_accessor :holder

  MAX_TILE_ID = 135

  def initialize(id)
    raise ArgumentError, '無効なIDです。' unless (0..MAX_TILE_ID).to_a.include?(id)

    @id = id
    @code = TILE_DEFINITIONS[id][:code]
    @name = TILE_DEFINITIONS[id][:name]
    @number = TILE_DEFINITIONS[id][:number]
    @holder = nil
  end

  def red_dora?(id)
    @id == id
  end
end
