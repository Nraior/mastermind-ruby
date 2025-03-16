class Board
  attr_reader :board, :current_level

  def initialize(height_levels, code_size)
    @board = new_board(height_levels, code_size)
    @height = height_levels
    @current_level = height_levels
  end

  def reset
    @board = new_board
    @current_level = height
  end

  def set_level_code(code)
    @board[current_level] = code
    @current_level -= 1
  end

  private

  def new_board(height_levels, code_size)
    Array.new(height_levels) { Array.new(code_size) { '-' } }
  end
end
