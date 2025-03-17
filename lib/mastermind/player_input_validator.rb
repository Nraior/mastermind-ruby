class PlayerInputValidator
  def self.validate(input, rules)
    splitted_code = input.chars

    correct_length = correct_length?(splitted_code.length, rules.code_length)
    valid_colors = valid_colors_used?(splitted_code, rules.color_pool)
    duplicates_check = duplicates?(rules, splitted_code)
    show_wrong_length_message(splitted_code.length, rules.code_length) unless correct_length
    show_wrong_codes_used_message(rules.print_available_colors_short) unless valid_colors
    show_duplicates_error_message if duplicates_check

    correct_length && valid_colors && !duplicates_check
  end

  def self.show_duplicates_error_message
    puts 'Duplicates are not accepted'
  end

  def self.show_wrong_codes_used_message(available_colors)
    puts "Wrong codes used, please only #{available_colors}"
  end

  def self.show_wrong_length_message(code_length, original_code_length)
    puts "Code has wrong length, it is #{code_length} and should be #{original_code_length}"
  end

  def self.duplicates?(rules, splitted_code)
    !rules.allow_duplicates && (splitted_code.uniq.length != splitted_code.length)
  end

  def self.valid_colors_used?(code_arr, color_pool)
    code_arr.all? do |code_letter|
      color_pool.any? { |color| color.code == code_letter }
    end
  end

  def self.correct_length?(code_length, required_length)
    code_length == required_length
  end

  private_class_method :show_duplicates_error_message, :show_wrong_codes_used_message,
                       :show_wrong_length_message, :duplicates?, :valid_colors_used?,
                       :correct_length?
end
