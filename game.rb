require_relative 'board'
require_relative 'player'
require_relative 'display'

class Game

  attr_reader :board

  def initialize
    @board = Board.new
    @players = { red: HumanPlayer.new, black: HumanPlayer.new }
    @current_player = :red
  end

  def play_game
    board.render
    until game_over?
      players[current_player].play_turn
      current_player = (current_player = :red) ? :black : :red
    end

    puts board.render
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
