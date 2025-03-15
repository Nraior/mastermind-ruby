class Player
  def initialize(name)
    @name = name
    @score = 0
  end

  def add_score(score)
    @score += score
  end

  def ask_for_code(code_count, available_colors)
    code = gets
  end
end
