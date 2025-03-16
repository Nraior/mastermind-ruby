class GameRules
  attr_reader :code_length, :board_height, :allow_duplicates, :max_rounds, :color_pool

  def self.basic_rules(colors)
    new(4, 12, false, 6, colors)
  end

  def initialize(code_length, board_height, allow_duplicates, max_rounds, colors)
    @code_length = code_length
    @board_height = board_height
    @max_rounds = max_rounds
    @allow_duplicates = allow_duplicates
    @color_pool = colors
  end

  def print_available_colors
    color_pool.each do |color|
      p "Color: #{color.name}, code: #{color.code}"
    end
  end

  def print_available_colors_short
    color_pool.reduce('') do |acc, color|
      acc + " #{color.code}"
    end
  end
end
