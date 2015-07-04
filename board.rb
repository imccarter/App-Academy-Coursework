require 'colorize'
require_relative 'piece'
require_relative 'sliding_piece'
require_relative 'stepping_piece'
require_relative 'empty_square'
require_relative 'movement_module'

require 'byebug'


class Board

  include Enumerable

  PIECE_SEQUENCE = [Rook, Bishop, Knight, King, Queen, Knight, Bishop, Rook]
  PAWN_SEQUENCE = [Pawn] * 8

  attr_accessor :grid, :captures, :king_positions

  def initialize
    @grid = Array.new(8) { Array.new(8) { EmptySquare.new } }
    @captures = { :b => [], :w => [] }
    @king_positions = { }
    #set_default_board ...call in play loop
  end

  def [](row, col)
    grid[row][col]
  end

  def piece_at(pos)
    { :color => self[*pos].color, :piece => self[*pos].class }
  end

  def []=(row, col, piece)
    grid[row][col] = piece
    update_piece_pos(piece, [row, col])
  end

  def update_piece_pos(piece, pos)
    piece.update_pos(pos)
  end

  def each(&blk)
    grid.each do |row|
      row.each do |el|
        blk.call(el)
      end
    end
  end

  def each_with_coord(&blk)
    grid.each_with_index do |row, r_id|
      row.each_with_index do |el, c_id|
        blk.call(el, [r_id, c_id])
      end
    end
  end

  def move_piece(piece, dest)
    test_board = dup
    origin = piece.pos.dup
    duped_piece = test_board[*origin]
    test_board[*dest] = duped_piece
    test_board[*origin] = EmptySquare.new
    duped_piece.relay_king_pos if duped_piece.is_a?(King)
    test_board
  end

  def move_piece!(piece, dest)
    #validation in cursor/play
    captures[piece.color] << self[*dest] if !empty?(dest)
    origin = piece.pos
    self[*dest] = piece
    self[*origin] = EmptySquare.new
    piece.relay_king_pos if piece.is_a?(King)
  end

  def dup
    duped_board = Board.new
    each_with_coord do |piece, pos|
      # debugger
      duped_board[*pos] = self[*pos].duper(duped_board) if !self.empty?(pos)
    end
    # debugger
    duped_board
  end


  def in_check?(color)
    pieces_of(Board.other(color)).any? { |opponent_piece| opponent_piece.threatens_king? }
  end

  def in_check_mate?(color)
    pieces_of(color).map do |piece|
      piece.valid_moves
    end.flatten(1).count == 0
  end

  def self.other(color)
    color == :b ? :w : :b
  end

  def pieces_of(color)
    inject([]) do |so_far, piece|
      so_far << piece if piece.color == color && !empty?(piece.pos)
      so_far
    end
  end

  def on_board?(pos)
    pos[0].between?(0, 7) && pos[1].between?(0, 7)
  end

  def occupied?(pos)
    !self[*pos].is_a?(EmptySquare)
  end

  def empty?(pos)
    self[*pos].is_a?(EmptySquare)
  end

  def terminal?(position)
    !on_board?(position) || occupied?(position)
  end

  def render_board
    black_square = true
    @grid.each do |row|
      black_square = !black_square
      render_row(row, black_square)
      puts
    end
  end

  def place(positions)
    positions.each { |pos| self[*pos] = Rook.new(:b, self) }
  end

  def render_row(row, black_square)
    row.map do |element|
      black_square = !black_square
      if black_square
        print (" " + element.render + " ").colorize(background: :magenta)
      else
        print (" " + element.render + " ").colorize(background: :cyan)
      end
    end
  end

  def set_default_board
    PIECE_SEQUENCE.each_with_index do |type, idx|
      self[0, idx] = type.new(:b, self)
    end

    PAWN_SEQUENCE.each_with_index do |type, idx|
      self[1, idx] = Pawn.new(:b, self)
    end

    PAWN_SEQUENCE.each_with_index do |type, idx|
      self[6, idx] = Pawn.new(:w, self)
    end

    PIECE_SEQUENCE.reverse.each_with_index do |type, idx|
      self[7, idx] = type.new(:w, self)
    end
  end

end

board = Board.new
k = King.new(:w, board)
r = Rook.new(:b, board)
board[0,1] = k
board.move_piece!(k, [0,0])
q1 = Queen.new(:b, board)
q2 = Queen.new(:b, board)
board[0,5] = q1

board.render_board
p board.in_check?(:w)
p board.in_check_mate?(:w)
p k.valid_moves
