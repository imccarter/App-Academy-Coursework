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

  def valid_pos?(pos)
    pos.none? { |val| val < 0 || val > 7 }

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

  def setup_red

  end

  def setup_black

  end

end

board = Board.new
puts board.render
