require_relative 'piece'
require 'byebug'
require 'colorize'

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

  def valid_and_empty?(pos)
    valid_pos?(pos) && !occupied?(pos)
  end

  def populate_board(setup_pieces)
    @grid = Array.new(8) { Array.new(8) }
    return unless setup_pieces
    setup(:red)
    setup(:black)
  end

  def render
    grid.map.with_index do |row, i|
      row.map.with_index do |square, j|
        if square.nil?
          valid_pos?([i, j]) ? "   ".colorize(background: :red) : "   ".colorize(background: :blue)
        else
          square.render
        end
      end.join
    end.join("\n")
  end


  def dup
    duped_board = Board.new(false)
    pieces.each do |piece|
      duped_board.add_piece(piece.dup(duped_board), piece.pos)
    end

    duped_board
  end

  def add_piece(piece, pos)
    self[pos] = piece
  end

  def pieces
    @grid.flatten.compact
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

#TESTS
board = Board.new

move_seq = [[]]

enemy_pos = [4,1]

board[enemy_pos] = Piece.new(:black, board, enemy_pos)

puts board.render
puts
