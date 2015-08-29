require 'colorize'
require_relative 'movement_module'
require "byebug"

class Piece

  include Movement
  attr_accessor :pos
  attr_reader :color, :board, :directions

  def initialize(color, board, directions)
    @color = color
    @pos
    @board = board
    @directions = directions
  end

  def update_pos(position)
    self.pos = position
  end

  def capturable?(current_position)
    board.occupied?(current_position) && board[*current_position].color != color
  end

  def threatens_king?
    king_pos = board.king_positions[Board.other(color)]
    possible_moves.any? { |pos| pos == king_pos }
  end

  def displace(position, vector)
    displaced_pos = position.dup
    displaced_pos[0] += vector[0]
    displaced_pos[1] += vector[1]
    displaced_pos
  end

  def scale(vector, a)
    scaled = vector.dup
    scaled[0] *= a
    scaled[1] *= a
    scaled
  end

  def possible_move?(position)
    board.on_board?(position) && (board.empty?(position) || capturable?(position))
    #add check checking here.
  end

  def duper(duped_board)
    self.class.new(color, duped_board)
  end

  def moves
    puts "piece not specified"
  end
end


class Pawn < Piece
  PAWN_DIRECTIONS = []#todo

  def initialize(color, board)
    super(color, board, PAWN_DIRECTIONS)
  end

  def render
    code = (color == :b ? "\u265F" : "\u2659")
    code.encode('utf-8')
  end

end
