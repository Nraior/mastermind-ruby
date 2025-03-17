class ViewController
  def display_rules(rules)
    puts "Code Length is: #{rules.code_length}"
    rules.print_available_colors
  end

  def display_board(board)
    board.board.each_with_index do |level, index|
      p level.join(' ') + " #{board.feedback_history[index]}"
    end
    puts ''
  end

  def print_ask_code_maker(name)
    puts "#{name} please set the code"
  end

  def print_code_set_message(code_count)
    puts "code set: #{'*' * code_count}"
  end

  def print_code_breaker_initial_ask(name)
    puts "#{name} Try to break code"
  end

  def feedback(feedback)
    correct = feedback[:correct]
    correct_color = feedback[:correct_color]
    wrong = feedback[:wrong]

    "Correct: #{correct}. Wrong Pos: #{correct_color}, Wrong: #{wrong}"
  end

  def show_feedback(feedback)
    puts feedback(feedback)
  end

  def print_award_points_message(points)
    puts "Codemaker awarded: #{points}"
  end

  def print_round_ended_message
    puts "ROUND ENDED \n\n"
  end

  def print_game_ended_message
    puts 'Game ended'
  end

  def print_player_score(player)
    puts "#{player.name}: #{player.score}"
  end

  def clear_terminal
    system 'clear'
  end
end
