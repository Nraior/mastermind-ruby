class PlayerInputValidator
  def self.validate(input, rules)
    splitted_code = input.split('')

    correct_length = correct_length?(splitted_code.length, rules.code_length)
    valid_colors = valid_colors_used?(splitted_code, rules.color_pool)
    duplicates_check = duplicates?(rules, splitted_code)

    puts "Code has wrong length, it is #{splitted_code.length} and should be #{rules.code_length}" unless correct_length
    puts "Wrong codes used, please only #{rules.print_available_colors_short}" unless valid_colors
    puts 'Duplicates are not accepted' if duplicates_check

    correct_length && valid_colors && !duplicates_check
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
end
