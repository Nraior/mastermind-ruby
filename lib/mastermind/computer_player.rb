class ComputerPlayer < Player
  def input_code(rules)
    computer_code = ''
    colors = rules.color_pool.shuffle
    rules.code_length.times do
      computer_code << colors.pop.code
    end
    computer_code
  end

  def ask_break_code(rules, board)
    puts 'Let me guess...'
    # make initial guess
    if board.current_level == rules.board_height
      @whole_set = all_combinations(rules)
      return @whole_set.sample.join
    end

    # get feedback for last guess
    last_guess = board.board[board.current_level + 1].join
    last_guess_feedback = board.feedback_history[board.current_level + 1]

    @whole_set = @whole_set.filter do |set|
      set = set.join
      exclude_last_set = set != last_guess

      corrects = last_guess_feedback[:correct]
      correct_colors = last_guess_feedback[:correct_color]
      wrong = last_guess_feedback[:wrong]

      max_corrects = corrects
      wrong_pos_possibles = correct_colors + max_corrects
      wrongs = wrong

      set.chars.each_with_index do |set_char, index|
        max_corrects -= 1 if set_char == last_guess[index]
        wrong_pos_possibles -= 1 if last_guess.include?(set_char)
        wrongs -= 1 unless last_guess.include?(set_char)
      end

      correct_wrongs = wrongs >= 0
      correct_possibles = wrong_pos_possibles >= 0
      corrects_match = max_corrects.zero?

      exclude_last_set && corrects_match && correct_possibles && correct_wrongs
    end
    gets
    @whole_set.sample.join
  end

  private

  def find_combinations(rules)
    @whole_set = all_combinations(rules)
  end

  def all_combinations(rules)
    color_codes = rules.color_pool.map do |color|
      color.code
    end

    return color_codes.repeated_permutation(rules.code_length).to_a if rules.allow_duplicates

    color_codes.permutation(rules.code_length).to_a
  end
end
