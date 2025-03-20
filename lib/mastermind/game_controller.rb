require_relative 'board'
require_relative 'view_controller'
require_relative 'code_checker'

class GameController
  def initialize(rules)
    @rules = rules
    @board = Board.new(rules.board_height, rules.code_length)
    @view = ViewController.new
    @playing = false
    @round_playing = false
    @round = 0
    @code = ''
    @players = []
  end

  def update_players(players)
    @players = players
  end

  def start_game
    return @view.not_enough_players unless @players.length >= 2

    @playing = true
    @round_playing = true
    game_loop
  end

  private

  def end_round(current_level)
    @round_playing = false
    points = current_level.zero? ? @rules.board_height - current_level + 1 : @rules.board_height - current_level
    @view.print_award_points_message(points)
    code_breaker.add_score(points)
    @round += 1
    @board.reset
    @view.print_round_ended_message
  end

  def handle_game_end
    @view.print_game_ended_message
    @board.reset
    @players.each { |player| @view.print_player_score(player) }
    @playing = false
  end

  def code_breaker
    @players[@round % 2]
  end

  def code_maker
    @players[((@round + 1) % 2)]
  end

  def game_loop
    while @playing
      @view.display_rules(@rules)
      @view.print_ask_code_maker(code_breaker.name)
      @code = code_maker.ask_for_code(@rules)
      # @view.clear_terminal
      @view.print_code_set_message(@rules.code_length)
      @view.print_code_breaker_initial_ask(code_maker.name)
      round_loop
    end
  end

  def round_loop
    @round_playing = true
    while @round_playing
      @view.display_board(@board)
      code_to_check = code_breaker.ask_break_code(@rules, @board)
      check_breaker_code(code_to_check)
    end

    handle_game_end if end_game?
  end

  def end_game?
    @round >= @rules.max_rounds
  end

  def check_breaker_code(code)
    check_result = CodeChecker.check_code(code, @code)
    return end_round(@board.current_level) if check_result == true || @board.code_not_found_and_finished?

    @board.update_current_level_data(code.chars, check_result)
    @view.clear_terminal
  end
end
