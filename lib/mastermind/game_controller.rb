require_relative 'board'
require_relative 'view_controller'

class GameController
  def initialize(colors, board_height, code_length, max_rounds)
    @board = Board.new(board_height, code_length)
    @view = ViewController.new
    @colors = colors
    @playing = false
    @max_rounds = max_rounds
    @round = 0
    @code_length = code_length
    @code = ''
  end

  def start_game
    @playing = true
    @view.display_board(@board)
  end

  def end_round
  end

  def stop_game
    @playing = false
  end

  def game_loop
    return unless @code.length < @code_length

    @code = @player.ask_for_code
  end

  def finish_game
  end
end

# Controller - Manages the game, full focus
# Player = contains
