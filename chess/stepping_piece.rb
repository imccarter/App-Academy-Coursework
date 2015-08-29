require_relative "piece"
require 'byebug'

class SteppingPiece < Piece

  def initialize(color, board, directions)
    super(color, board, directions)
  end

  def possible_moves
    directions.inject([]) do |so_far, vector|
      cur_pos = displace(pos, vector)
      so_far << cur_pos if possible_move?(cur_pos)
      so_far
    end
  end

  def valid_moves
    possible_moves.reject do |position|
      board.move_piece(self, position).in_check?(self.color)
    end
  end

end

class Knight < SteppingPiece
  KNIGHT_DIRECTIONS = [[1,2], [-1, 2], [-1, -2], [1, -2], [2, 1], [-2, 1], [-2, -1], [2, -1]]

  def initialize(color, board)
    super(color, board, KNIGHT_DIRECTIONS)
  end

  def render
    code = (color == :b ? "\u265E" : "\u2658")
    code.encode('utf-8')
  end

end

class King < SteppingPiece

  KING_DIRECTIONS = [:N, :W, :S, :E, :NW, :SW, :NE, :SE].map do |direction|
    DIRECTION_HASH[direction]
  end

  def relay_king_pos
    board.king_positions[color] = pos
  end

  def initialize(color, board)
    super(color, board, KING_DIRECTIONS)
  end

  def render
    code = (color == :b ? "\u265A" : "\u2654")
    code.encode('utf-8')
  end

end
