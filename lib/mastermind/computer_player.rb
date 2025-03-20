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
    gets
    @whole_set.sample.join
  end

  private

  def filter_possible_moves(last_guess, last_guess_feedback)
    @whole_set.filter do |set|
      corrects_pos_good = wrong_pos_count_good?(set, last_guess, last_guess_feedback)
      corrects_good = corrects_count_good?(set, last_guess, last_guess_feedback)
      not_same_set = set.join != last_guess
      not_same_set && corrects_pos_good && corrects_good
    end
  end

  def wrong_pos_count_good?(checked_set, last_guess, last_guess_feedback)
    wrong_pos_possibles = last_guess_feedback[:correct_color] + last_guess_feedback[:correct]
    hash_set = last_guess.chars.tally
    checked_set.each do |set_char|
      next unless hash_set.include?(set_char)

      hash_set[set_char] -= 1
      hash_set.delete(set_char) if hash_set[set_char] <= 0
      wrong_pos_possibles -= 1
    end
    wrong_pos_possibles.zero?
  end

  def corrects_count_good?(checked_set, last_guess, last_guess_feedback)
    max_corrects = last_guess_feedback[:correct]
    checked_set.each_with_index do |set_char, index|
      max_corrects -= 1 if set_char == last_guess[index]
    end
    max_corrects.zero?
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
