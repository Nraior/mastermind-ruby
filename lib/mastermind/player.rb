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
      code = input_code(rules)
      return code if PlayerInputValidator.validate(code, rules)
    end
  end

  def ask_break_code(rules, _board)
    ask_for_code(rules)
  end

  private

  def input_code(_rules)
    gets.chomp.upcase
  end
end
