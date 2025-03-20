class CodeChecker
  def self.check_code(tried_code, code)
    return true if tried_code.downcase == code.downcase

    prepare_feedback(tried_code, code)
  end

  def self.prepare_feedback(tried_code, code)
    feedback = { correct: 0, correct_color: 0, wrong: 0 }
    player_code_hash = tried_code.chars.tally

    # first search for correct positions
    handle_feedback_for_exact_pos(code, tried_code, feedback, player_code_hash)
    code.chars.each_with_index do |code_letter, index|
      check_code_and_update_feedback(tried_code, code_letter, index, feedback, player_code_hash)
    end
    feedback
  end

  def self.handle_feedback_for_exact_pos(code, player_code, feedback, player_code_hash)
    code.chars.each_with_index do |code_letter, index|
      if player_code[index] == code_letter
        feedback[:correct] += 1
        player_code_hash[code_letter] > 1 ? player_code_hash[code_letter] -= 1 : player_code_hash.delete(code_letter)
      end
    end
  end

  def self.check_code_and_update_feedback(player_code, code_letter, index, feedback, player_code_hash)
    if player_code[index] == code_letter
      nil
    elsif player_code_hash[code_letter]
      player_code_hash[code_letter] > 1 ? player_code_hash[code_letter] -= 1 : player_code_hash.delete(code_letter)
      feedback[:correct_color] += 1
    else
      feedback[:wrong] += 1
    end
  end

  private_class_method :prepare_feedback, :check_code_and_update_feedback, :handle_feedback_for_exact_pos
end
