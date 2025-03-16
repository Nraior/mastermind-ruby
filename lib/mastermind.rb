require_relative 'mastermind/game'
require_relative 'mastermind/color'
require_relative 'mastermind/player'
require_relative 'mastermind/game_rules'

colors = [
  Color.new('blue', 'B'), Color.new('red', 'R'),
  Color.new('green', 'G'), Color.new('orange', 'O'),
  Color.new('purple', 'P'), Color.new(' cyan', 'C')
]

rules = GameRules.basic_rules(colors)

game = Game.new(rules)
game.add_player(Player.new('Damien'))
game.add_player(Player.new('George'))
game.start
