require 'byebug'


class Piece

  attr_reader :color, :board
  attr_accessor :pos, :kinged

  MOVE_DIFFS = {
    SW: [1, -1],
    SE: [1, 1],
    NW: [-1, -1],
    NE: [-1, 1]
  }

  def initialize(color, board, pos, kinged = false)
    @color = color #Black starts on "top"
    @board = board
    @pos = pos
    @kinged = kinged
  end

  def other_color
    color == :red ? :black : :red
  end


  def perform_slide(dest)
    return false unless board.valid_pos?(dest)
    x, y = pos
    possible_slides = []
    move_diffs.each { |dx, dy| possible_slides << [(x + dx), (y + dy)] }

    make_slide(possible_slides, dest)
  end

  def can_make_slide?(slides, dest)
    slides.include?(dest) && !board.occupied?(dest)
  end

  def make_slide(slides, dest) #Used by perform_slide; either moves the pieces + returns true, or returns false
    if can_make_slide?(slides, dest)
      board[pos], board[dest], self.pos = nil, self, dest
      true
    else
      false
    end
  end

  def perform_jump(dest)
    return false unless board.valid_pos?(dest)
    x, y = pos
    idest, jdest = dest

    possible_jumps = []
    move_diffs.each { |dx, dy| possible_jumps << [x + (dx * 2), y + (dy * 2)] }
    jumped_pos = [(x + idest) / 2, (y + jdest) / 2]

    make_jump(possible_jumps, jumped_pos, dest)
  end

  def occupied_by_enemy?(pos)
    board.occupied?(pos) && board[pos].color == other_color
  end

  def can_make_jump?(jumps, jumped_pos, dest)
    jumps.include?(dest) &&
    !board.occupied?(dest) &&
    occupied_by_enemy?(jumped_pos)
  end

  def make_jump(jumps, jumped_pos, dest) #Used by perform_jump; either moves the pieces + returns true, or returns false
    if can_make_jump?(jumps, jumped_pos, dest)
      board[pos], board[dest], self.pos = nil, self, dest
      board[jumped_pos] = nil
      true
    else
      false
    end
  end

  def dup(duped_board) #Only should be called by board#dup
    self.class.new(@color, duped_board, @pos, @kinged)
  end



  def perform_moves!(move_sequence)#takes an array of positions (or moves)
    if move_sequence.length == 1
      if is_legal_slide?(move_sequence.first)
        perform_slide(move_sequence.shift)
      elsif is_legal_jump?(move_sequence.first)
        perform_jump(move_sequence.shift)
      else
        illegal_move_error
      end

    else
      until move_sequence.empty?
        if is_legal_jump?(move_sequence.first)
          perform_jump(move_sequence.shift)
        else
          illegal_move_error
        end
      end
    end
  end

  def is_legal_jump?(dest)
    is_jump?(dest) && board.valid_and_empty?(dest)
  end

  def is_legal_slide?(dest)
    is_slide?(dest) && board.valid_and_empty?(dest)
  end

  def illegal_move_error
    raise InvalidMoveError.new "Cannot move there!"
  end

  def valid_move_seq?(move_sequence)
    test_board = board.dup
    begin
      test_board.perform_moves!(move_sequence)
    rescue InvalidMoveError
      return false
    end
    true
  end


  def perform_moves(move_sequence)
    if valid_move_seq?(move_sequence)
      perform_moves!(move_sequence)
    else
      raise InvalidMoveError.new "Invalid move sequence!"
    end
  end

  def is_slide?(dest)
    x, y = pos
    xd, yd = dest
    (xd - x).abs == 1 && (yd - y).abs == 1
  end

  def is_jump?(dest)
    x, y = pos
    xd, yd = dest
    (xd - x).abs == 2 && (yd - y).abs == 2
  end

  def move_diffs
    if kinged #kings move in any direction
      MOVE_DIFFS.values
    elsif color == :red #red moves up
      [MOVE_DIFFS[:NE], MOVE_DIFFS[:NW]]
    else #black moves down
      [MOVE_DIFFS[:SE], MOVE_DIFFS[:SW]]
    end
  end

  def render
    render_char.colorize(background: :red)
  end

  def render_char
    if color == :black
      kinged ? ' ' + "\u2655" + ' ' : ' ' + "\u2659" + ' '
    else
      kinged ? ' ' + "\u265B" + ' ' : ' ' + "\u265F" + ' '
    end
  end

end
