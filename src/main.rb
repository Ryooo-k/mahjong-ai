require 'debug'
require 'json'

require_relative 'environment/env'
require_relative 'agent/qnet'
require_relative 'agent/dqn_agent'

Tiles = {
  0=> '1萬', 1=> '2萬', 2=> '3萬', 3=> '4萬', 4=> '5萬', 5=> '6萬', 6=> '7萬', 7=> '8萬', 8=> '9萬',
  9=> '1筒', 10=> '2筒', 11=> '3筒', 12=> '4筒', 13=> '5筒', 14=> '6筒', 15=> '7筒', 16=> '8筒', 17=> '9筒',
  18=> '1索', 19=> '2索', 20=> '3索', 21=> '4索', 22=> '5索', 23=> '6索', 24=> '7索', 25=> '8索', 26=> '9索',
  27=> '東',28=> '南', 29=> '西', 30=> '北', 31=> '白',32=> '発', 33=> '中'
}

def main
  sync_interval = 1000
  agent = DQNAgent.new
  syanten_list = load_shanten_list

  1000000.times do |time|
    total_loss = 0
    done = false
    env = MahjongEnv.new(syanten_list, time)
    start_hands = env.hands.dup
    state = env.state

    while not done
      env.tumo
      action = agent.get_action(state)
      next_state, reward, done = env.step(action)
      loss = agent.update(state, action, reward, next_state, done)
      total_loss += loss
      state = next_state
    end

    agent.sync_qnet if time != 0 && time % sync_interval == 0
    average_loss = total_loss / env.order

    if time % 10 == 0
      puts "開始時の向聴数：#{env.shanten(start_hands)}"
      puts "終了時の向聴数：#{env.shanten(env.hands)}"
      puts "アベレージロス：#{average_loss}、終了順目：#{env.order}"
      puts
    end
  end
end

def load_shanten_list
  file = File.read('src/data/shanten_list.json')
  JSON.parse(file)
end

def to_tiles(hands)
  hands.map { |hand| Tiles[hand] }
end

main
