require_relative 'mastermind/game'
require_relative 'mastermind/color'

colors = [
  Color.new('blue', 'B'), Color.new('red', 'R'),
  Color.new('green', 'G'), Color.new('orange', 'O'),
  Color.new('purple', 'P'), Color.new(' cyan', 'C')
]

game = Game.new(colors)
game.start
