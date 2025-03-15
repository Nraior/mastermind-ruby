require_relative 'game_controller'
class Game
  def initialize(color_pool)
    @controller = GameController.new(color_pool, 12, 4)
    @color_pool = color_pool
    @players = []
  end

  def add_player(player)
    @players << player
  end

  def start
    @controller.start_game
  end
end
