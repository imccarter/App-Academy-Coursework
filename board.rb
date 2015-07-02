require_relative 'piece'

class Board

  attr_accessor :grid

  def initialize(setup_pieces = true)
    populate_board(setup_pieces)
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    grid[row][col] = piece
  end

  def valid_pos?(pos) #Only checks if square is on the board and potentially movable to, NOT if occupied.
    if pos.none? { |val| val < 0 || val > 7 }
      r, c = pos
      return false if r.even? && c.even? || r.odd? && c.odd?
      return true
    end
    false
  end

  def occupied?(pos)
    !self[pos].nil?
  end

  def populate_board(setup_pieces)
    @grid = Array.new(8) { Array.new(8) }
    return unless setup_pieces
    setup_red
    setup_black
  end

  def render
    grid.map do |row|
      row.map do |square|
        square.nil? ? ' . ' : square.render
      end.join
    end.join("\n")
  end

  def setup_red #Red starts on "bottom"
    grid[0..2].each_with_index do |bot_row, r_id|
      bot_row.each_with_index do |square, c_id|
        square = [7 - r_id, 7 - c_id]
        self[square] = Piece.new(:r, self, square, false) if valid_pos?(square)
      end
    end
  end

  def setup_black #Black starts on "top"
    grid[0..2].each_with_index do |bot_row, r_id|
      bot_row.each_with_index do |square, c_id|
        square = [r_id, c_id]
        self[square] = Piece.new(:b, self, square, false) if valid_pos?(square)
      end
    end
  end




end

board = Board.new
pos = [5, 0]
dest = [4, 1]


board[pos].perform_slide(dest)

puts board.render
