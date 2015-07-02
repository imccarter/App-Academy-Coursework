require_relative 'piece'

class Board

  attr_reader :grid

  def initialize(setup_pieces = true)
    create_board(setup_pieces)
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    grid[row][col] = piece
  end

  def valid_pos?(pos) #Only checks if square is on the board and movable to, NOT if occupied.
    if pos.none? { |val| val < 0 || val > 7 }
      r, c = pos
      return false if r.even? && c.even? || r.odd? && c.odd?
      return true
    end
    false
  end




  def create_board(setup_pieces)
    @grid = Array.new(8) { Array.new(8) }
    return unless setup_pieces
    setup_red
    setup_black
  end

  def render
    grid.map do |row|
      row.map do |square|
        square.nil? ? ' . ' : piece.render
      end.join
    end.join("\n")
  end

  def setup_red #Red starts on "bottom"

  end

  def setup_black #Black starts on "top"

  end

end

board = Board.new
puts board.render
pos = [7,0]
p board.valid_pos?(pos)
