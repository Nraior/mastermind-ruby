require_relative 'board'
require_relative 'view_controller'
require_relative 'code_checker'

class GameController
  def initialize(rules)
    @rules = rules
    @board = Board.new(rules.board_height, rules.code_length)
    @view = ViewController.new
    @playing = false
    @round = 0
    @code = ''
    @players = []
  end

  def update_players(players)
    @players = players
  end

  def start_game
    unless @players.length >= 2
      @view.not_enough_players
      return
    end

    @playing = true
    # @view.display_board(@board)
    game_loop
  end

  def end_round(current_level)
    @playing = false
    points = current_level == 0 ? @rules.board_height - current_level + 1 : @rules.board_height - current_level

    puts "codemaker awarded: #{points} "
    # Evaluate points
    code_breaker
  end

  def code_breaker
    @players[@round % 2]
  end

  def code_maker
    @players[(@round + 1 % 2)]
  end

  def stop_game
  end

  def next_round
    p 'Next round'
  end

  def game_loop
    @view.display_rules(@rules)
    puts "#{code_maker.name} please set code"
    @code = code_maker.ask_for_code(@rules)
    puts 'Code setted'
    puts "#{code_breaker.name} Try to break code"
    while @playing
      code_to_check = code_breaker.ask_break_code(@rules)
      check_result = CodeChecker.check_code(code_to_check, @code)
      @board.set_level_code(code_to_check)
      end_round(@board.current_level) if check_result == true || @board.current_level.negative?
      next_round
      #
    end
  end

  def finish_game
  end
end
