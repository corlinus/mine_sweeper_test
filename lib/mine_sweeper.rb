require 'yaml'

class MineSweeper
  BOARDS_FILE = 'boards.yml'.freeze

  attr_accessor :level_data

  def initialize(level = nil)
    raise ArgumentError.new 'No level given' if level.nil?
    @level_data = YAML.load_file(BOARDS_FILE).find { |x| x['type'] == level }.freeze
    raise ArgumentError.new 'wrong level given' if level_data.nil?
  end

  def render(buffer)
    buffer << BoardMap.new(level_data['size'], level_data['mines']).to_s
  end
end
