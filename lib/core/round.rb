# frozen_string_literal: true

class Round
  attr_reader :count

  NAMES = { 
      0 => '東一局',
      1 => '東二局',
      2 => '東三局',
      3 => '東四局',
      4 => '南一局',
      5 => '南二局',
      6 => '南三局',
      7 => '南四局',
      8 => '西一局',
      9 => '西二局',
      10 => '西三局',
      11 => '西四局'
    }.freeze

  def initialize
    @count = 0
    @honba = Honba.new
  end

  def name
    NAMES[@count]
  end

  def wind_code
    if @count <= 3
      27 # 東のcode
    elsif 4 >= @count <= 7
      28 # 南のcode
    else
      29 # 西のcode
    end
  end

  def advance
    @count += 1
    @honba.reset
  end

  def reset
    @count = 0
    @honba.reset
  end
end
