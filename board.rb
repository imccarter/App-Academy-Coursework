require_relative 'piece'
require 'byebug'

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
      x, y = pos
      return x.even? && y.odd? || x.odd? && y.even?
    end
    false
  end

  def occupied?(pos)
    !self[pos].nil?
  end

  def populate_board(setup_pieces)
    @grid = Array.new(8) { Array.new(8) }
    return unless setup_pieces
    setup(:red)
    setup(:black)
  end

  def render
    grid.map do |row|
      row.map do |square|
        square.nil? ? ' . ' : square.render
      end.join
    end.join("\n")
  end

  def setup(color)
    3.times do |i|
      8.times do |j|
        pos = color == :red ? [7 - i, 7 - j] : [i, j] #red on "bottom", black on "top"
        self[pos] = Piece.new(color, self, pos) if valid_pos?(pos)
      end
    end
  end
end

board = Board.new
pos = [5, 0]
enemy = [4,1]
board[enemy] = Piece.new(:black, board, enemy)
dest = [3, 2]
puts board.render

p board[pos].perform_jump(dest)

puts board.render
