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
    return initial_guess(rules) if board.first_guess?

    @whole_set = filter_possible_moves(board.last_guess, board.last_guess_feedback)
    puts @whole_set.length
    gets
    @whole_set.sample.join
  end

  private

  def filter_possible_moves(last_guess, last_guess_feedback)
    @whole_set.filter do |set|
      max_corrects = last_guess_feedback[:correct]
      wrongs = last_guess_feedback[:wrong]
      wrong_pos_possibles = last_guess_feedback[:correct_color] + max_corrects

      set.each_with_index do |set_char, index|
        max_corrects -= 1 if set_char == last_guess[index]
        wrong_pos_possibles += handle_correct_color_wrong_pos(last_guess.chars.tally, set_char)
        wrongs -= 1 unless last_guess.include?(set_char)
      end

      set_not_filtered?(set.join != last_guess, wrongs, wrong_pos_possibles, max_corrects)
    end
  end

  def wrongs_count_good?(checked_set, last_guess, last_guess_feedback)
    wrongs = last_guess_feedback[:wrong]
    checked_set.each_with_index do |set_char, index|
      wrongs -= 1 unless last_guess.include?(set_char)
    end

    wrongs >= 0
  end

  def handle_correct_color_wrong_pos(hash_set, set_char)
    return 0 unless hash_set.include?(set_char)

    hash_set[set_char] -= 1
    hash_set.delete(set_char) if hash_set[set_char] <= 0
    -1
  end

  def set_not_filtered?(is_different_set, wrongs, wrong_pos_possibles, max_corrects)
    correct_wrongs = wrongs >= 0
    correct_possibles = wrong_pos_possibles >= 0
    corrects_match = max_corrects.zero?

    is_different_set && corrects_match && correct_possibles && correct_wrongs
  end

  def initial_guess(rules)
    @whole_set = all_combinations(rules)
    @whole_set.sample.join
  end

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
