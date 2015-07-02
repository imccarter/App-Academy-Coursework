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

  def make_slide(slides, dest)
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

  def make_jump(jumps, jumped_pos, dest)
    if can_make_jump?(jumps, jumped_pos, dest)
      board[pos], board[dest], self.pos = nil, self, dest
      board[jumped_pos] = nil
      true
    else
      false
    end
  end

  def perform_moves!(move_sequence)
    

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
    if color == :black
      kinged ? (' ' + "\u2655" + ' ') : (' ' + "\u2659" + ' ')
    else
      kinged ? (' ' + "\u265B" + ' ') : (' ' + "\u265F" + ' ')
    end
  end

end
