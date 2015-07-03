require_relative 'board'
require_relative 'player'
require_relative 'display'

class Game

  attr_reader :board, :players, :current_player

  def initialize
    @board = Board.new
    @players = { red: HumanPlayer.new(:red), black: HumanPlayer.new(:black) }
    @current_player = :red
  end

  def play_game
    until game_over?
      players[current_player].play_turn(board)
      @current_player = (current_player == :red) ? :black : :red
    end

    game_over?
  end

  def game_over?
    if board.pieces.all? { |piece| piece.color == :red }
      puts "Red wins!"
      true
    elsif board.pieces.all? { |piece| piece.color == :black }
      puts "Black wins!"
      true
    else
      false
    end
  end
end

game = Game.new
game.play_game
