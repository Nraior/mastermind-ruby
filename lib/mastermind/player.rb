require_relative 'player_input_validator'
class Player
  attr_reader :name, :score

  def initialize(name)
    @name = name
    @score = 0
  end

  def add_score(score)
    @score += score
  end

  def ask_for_code(rules)
    loop do
      code = gets.chomp.upcase
      return code if PlayerInputValidator.validate(code, rules)
    end
  end

  def ask_break_code(rules)
    ask_for_code(rules)
  end
end
