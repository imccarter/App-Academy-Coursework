
class Player

  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class HumanPlayer < Player

  def initialize(color)
    super(color)
  end


  def play_turn(board)
    puts board.render
    puts "Current Player: #{color}"
    piece = board[piece_select]#select what piece to move
    move_seq = move_select#takes in selections to create an array of moves
    piece.perform_moves(move_seq)
  rescue InvalidSelectionError
    puts "That's not your piece!"
    retry
  rescue InvalidMoveError
    puts "That wasn't a valid move sequence, choose again!"
    retry
  end

  def piece_select
    puts "Choose a piece, eg. \"6,1\""
    piece_pos = gets.chomp.split(",").map! { |n| n.to_i }
    # raise InvalidSelectionError unless board[piece_pos].color == color
  end

  def move_select
    puts "Pick where to move it, eg. \"5,0 4,1\""
    move_seq = gets.chomp.split(" ")
    move_seq.map! { |coords| coords.split(",") }.map! { |pair| pair.map! { |n| n.to_i } }
  end
end

class InvalidSelectionError < StandardError
end
