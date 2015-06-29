require_relative 'board'

class Game
  attr_accessor :board

  def initialize(size = 9, bombs = 10)
    @board = Board.new(self, size, bombs)
  end

  def run
    board.render
    until board.over?
      take_turn
    end
    finish_game
  end

  def take_turn
    flag_or_reveal == "f" ? flag_turn : reveal_turn
    board.render
  end

  def flag_or_reveal
    puts "Would you like to place/remove a flag or reveal a tile? (f/r)"
    gets.chomp
  end

  def flag_turn
    puts "Which position would you like to flag or unflag? (e.g. 0,0)"
    pos = gets.chomp.split(",").map(&:to_i)
    board[pos].swap_flag
  end

  def reveal_turn
    puts "Which position would you like to reveal?"
    pos = gets.chomp.split(",").map(&:to_i)
    board.reveal_tiles(pos)
  end

  def finish_game
    print board.won? ? "You win" : "You blew up!"
  end
end
