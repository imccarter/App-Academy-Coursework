class Game

  def initialize(size = 9, bombs = 10)
    @board = Board.new(self, size, bombs)
  end

  def run
    catch (:lose) do
      take_turn until game_over?
    end
    finish_game
  end

  def take_turn
    flag_or_reveal == "f" ? flag_turn : reveal_turn
    board.render
  end

  def flag_or_reveal
    puts "Would you like to place/remove a flag or reveal a tile?"
    gets.chomp
  end

  def flag_turn
    puts "Which position would you like to flag or unflag?"
    pos = gets.chomp.split(",").map(&:to_i)
    board[pos].swap_flag
  end

  def reveal_turn
    puts "Which position would you like to reveal?"
    pos = gets.chomp.split(",").map(&:to_i)
    board.reveal_tiles(pos)
  end

  def game_over?

  end

  def finish_game
  end

  def lose
    board.reveal_bombs
    board.render
    puts "Sorry, you lose!"
  end


end
