# frozen_string_literal: true

require 'json'

module ShantenLoader
  def self.load(path = 'data/shanten_list.json')
    JSON.parse(File.read(path))
  end
end
