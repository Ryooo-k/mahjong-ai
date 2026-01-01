# frozen_string_literal: true

class GameMode
  RED_IDS = [19, 55, 91].freeze # 5萬, 5筒, 5索それぞれ１枚ずつを赤ドラの対象とする

  RULE_MAP = {
    0 => {
      participant_count: 4,
      round_type: '1局戦',
      end_round_count: 1,
      red_ids: RED_IDS
    },
    1 => {
      participant_count: 4,
      round_type: '東風戦',
      end_round_count: 4,
      red_ids: RED_IDS
    },
    2 => {
      participant_count: 4,
      round_type: '東南戦',
      end_round_count: 8,
      red_ids: RED_IDS
    }
  }.freeze

  def initialize(id)
    @rule = RULE_MAP[id]
  end

  def participant_count
    @rule[:participant_count]
  end

  def end_round_count
    @rule[:end_round_count]
  end

  def red_ids
    @rule[:red_ids]
  end
end
