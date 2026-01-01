# frozen_string_literal: true

require_relative './game_mode'
require_relative './player'
require_relative './round'
require_relative '../utils/formatter'

class Game
  attr_reader :game_mode, :players

  # 9萬→1萬、9筒→1筒、9索→1索、北→東、中→白のドラ変換テーブル
  SPECIAL_DORA_CONVERSION_TABLE = {
    8 => 0,
    17 => 9,
    26 => 18,
    30 => 27,
    33 => 31
  }.freeze
  TILE_COUNT = 136

  def initialize(config)
    @game_mode = GAME_MODE.new(config['game_mode_id'])
    @players = Array.new(@game_mode.participant_count) { |id| Player.new(id, config["player_#{id}"]) }
    @ordered_players = @players.shuffle
    @tiles = Array.new(TILE_COUNT) { |id| Tile.new(id) }
    @round = Round.new(@tiles)
  end

  def round_name
    @round.name
  end

  def round_wind
    @round.wind
  end

  def honba_count
    honba.count
  end

  def honba_name
    number_kanji = Utils::Formatter.convert_number_to_kanji(honba_count)
    "#{number_kanji}本場"
  end

  def increase_draw_count
    honba.draw_count += 1
  end

  def increase_kong_count
    honba.kan_count += 1
  end

  def ton_wind_player
    ordered_wind_players[0]
  end

  def nan_wind_player
    ordered_wind_players[1]
  end

  def sha_wind_player
    ordered_wind_players[2]
  end

  def pei_wind_player
    ordered_wind_players[3]
  end

  def host
    ton_wind_player
  end

  def children
    [nan_wind_player, sha_wind_player, pei_wind_player]
  end

  def top_tile
    honba.top_tile
  end

  def remaining_live_wall_count
    honba.remaining_live_wall_count
  end

  def dora_tile_codes
    dora_indicator_codes = honba.dora_indicators.map(&:code)
    dora_indicator_codes.map { |code| fetch(SPECIAL_DORA_CONVERSION_TABLE[code], code + 1) }
  end

  def ura_dora_tile_codes
    dora_indicator_codes = honba.ura_dora_indicators.map(&:code)
    dora_indicator_codes.map { |code| fetch(SPECIAL_DORA_CONVERSION_TABLE[code], code + 1) }
  end

  def ranked_players
    @ordered_players.reverse.sort_by(&:score).reverse
  end

  def advance_honba
    honba.advance
    @players.each(&:restart)
  end

  def advance_round
    @round.advance
    @players.each(&:restart)
  end

  def reset
    @players.each(&:reset)
    @round.reset
    @ordered_players = @players.shuffle
  end

  private

    def honba
      @round.honba
    end

    def ordered_wind_players
      host_index = @round.count % @game_mode.participant_count
      @ordered_players.rotate(host_index)
    end
end
