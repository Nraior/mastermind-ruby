class CodeChecker
  def self.check_code(tried_code, code)
    return true if tried_code.downcase == code.downcase

    prepare_feedback(tried_code, code)
  end

  def self.prepare_feedback(tried_code, code)
    feedback = { correct: 0, correct_color: 0, wrong: 0 }

    code.split('').each_with_index do |code_letter, index|
      p tried_code
      p code_letter

      if tried_code[index] == code_letter
        feedback[:correct] += 1
      elsif tried_code.include?(code_letter)
        p code
        p code_letter
        feedback[:correct_color] += 1
      else
        feedback[:wrong] += 1
      end
    end
    p feedback
    feedback
  end

  private_class_method :prepare_feedback
end
