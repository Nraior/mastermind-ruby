class Board
  attr_reader :board

  def initialize(height_levels, code_size)
    @board = new_board(height_levels, code_size)
  end

  def reset
    @board = new_board
  end

  def new_board(height_levels, code_size)
    Array.new(height_levels) { Array.new(code_size) { '-' } }
  end
end
