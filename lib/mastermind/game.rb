require_relative 'game_controller'
class Game
  def initialize(rules)
    @controller = GameController.new(rules)
    @players = []
  end

  def add_player(player)
    @players << player
    @controller.update_players(@players)
  end

  def start
    @controller.start_game
  end
end
