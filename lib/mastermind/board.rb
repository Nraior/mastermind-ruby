class Board
  attr_reader :board, :current_level, :feedback_history

  def initialize(height_levels, code_size)
    @height_levels = height_levels
    @code_size = code_size
    create_new_board(height_levels, code_size)
  end

  def reset
    create_new_board(@height_levels, @code_size)
  end

  def update_current_level_data(code, feedback)
    @board[current_level] = code
    @feedback_history[current_level] = feedback
    @current_level -= 1
  end

  def code_not_found_and_finished?
    @current_level.negative?
  end

  def first_guess?
    current_level == @height_levels
  end

  def last_guess
    board[current_level + 1].join
  end

  def last_guess_feedback
    feedback_history[current_level + 1]
  end

  private

  def create_new_board(height_levels, code_size)
    @board = new_board(height_levels, code_size)
    @feedback_history = new_feedback_history(height_levels)
    @current_level = height_levels
  end

  def new_feedback_history(height_levels)
    Array.new(height_levels) { '' }
  end

  def new_board(height_levels, code_size)
    Array.new(height_levels) { Array.new(code_size) { '-' } }
  end
end
