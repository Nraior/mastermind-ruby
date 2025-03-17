class CodeChecker
  def self.check_code(tried_code, code)
    return true if tried_code.downcase == code.downcase

    prepare_feedback(tried_code, code)
  end

  def self.prepare_feedback(tried_code, code)
    feedback = { correct: 0, correct_color: 0, wrong: 0 }

    code.split('').each_with_index do |code_letter, index|
      check_code_and_update_feedback(tried_code, code_letter, index, feedback)
    end
    feedback
  end

  def self.check_code_and_update_feedback(player_code, code_letter, index, feedback)
    if player_code[index] == code_letter
      feedback[:correct] += 1
    elsif player_code.include?(code_letter)
      feedback[:correct_color] += 1
    else
      feedback[:wrong] += 1
    end
  end

  private_class_method :prepare_feedback, :check_code_and_update_feedback
end
