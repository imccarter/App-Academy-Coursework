require_relative "piece"
require "byebug"

class SlidingPiece < Piece

  def initialize(color, board, directions)
    super(color, board, directions)
  end

  def possible_moves
    directions.inject([]) do |so_far, direction|
      so_far + explore_in_direction(direction)
    end
  end

  def valid_moves
    possible_moves.reject { |pos| board.move_piece(self, pos).in_check?(color) }
  end

  def explore_in_direction(direction)
    unit_vector = DIRECTION_HASH[direction].dup
    current_vector = unit_vector.dup
    current_position = displace(pos, current_vector)
    scalar = 2
    moves = []
    until board.terminal?(current_position)
      moves << current_position
      current_vector = scale(unit_vector, scalar)
      current_position = displace(pos, current_vector)
      scalar += 1
    end
    moves << current_position if possible_move?(current_position)
    moves
  end
end

class Rook < SlidingPiece
  ROOK_DIRECTIONS = [:N, :W, :S, :E]

  def initialize(color, board)
    super(color, board, ROOK_DIRECTIONS)
  end

  def render
    code = (color == :b ? "\u265C" : "\u2656")
    code.encode('utf-8')
  end

end

class Bishop < SlidingPiece
  BISHOP_DIRECTIONS = [:NW, :SW, :NE, :SE]

  def initialize(color, board)
    super(color, board, BISHOP_DIRECTIONS)
  end

  def render
    code = (color == :b ? "\u265D" : "\u2657")
    code.encode('utf-8')
  end

end

class Queen < SlidingPiece
  QUEEN_DIRECTIONS = [:N, :W, :S, :E, :NW, :SW, :NE, :SE]

  def initialize(color, board)
    super(color, board, QUEEN_DIRECTIONS)
  end

  def render
    code = (color == :b ? "\u265B" : "\u2655")
    code.encode('utf-8')
  end

end
