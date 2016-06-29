class BoardMap
  BOMB_CHAR  = '*'.freeze
  EMPTY_CHAR = '.'.freeze

  attr_accessor :size, :mines

  def initialize(size, mines)
    @size = size
    @mines = mines
  end

  def to_s
    board_map.map(&:join).join("\n") + "\n"
  end

  private

  def board_map
    return @board_map if @board_map
    @board_map = empty_board
    mines.each { |x, y| add_mine @board_map, x, y }
    @board_map
  end

  def empty_board
    Array.new(size).fill { Array.new(size).fill { EMPTY_CHAR.dup } }
  end

  def add_mine(board_map, x, y)
    [x - 1, x, x + 1].product [y - 1, y, y + 1] do |tx, ty|
      case
      when tx < 0             then next
      when tx > size - 1      then next
      when ty < 0             then next
      when ty > size - 1      then next
      when tx == x && ty == y then board_map[ty][tx] = BOMB_CHAR.dup
      else
        case board_map[ty][tx]
        when EMPTY_CHAR then board_map[ty][tx] = 1
        when Fixnum     then board_map[ty][tx] += 1
        else next
        end
      end
    end
  end
end
