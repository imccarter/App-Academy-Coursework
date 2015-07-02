class Piece

  attr_reader :color, :board
  attr_accessor :pos, :kinged

  MOVE_DIFFS = {
    :SW => [1, -1],
    :SE => [1, 1],
    :NW => [-1, -1],
    :NE => [-1, 1]
  }

  def initialize(color, board, pos, kinged = false)
    @color = color #Black starts on "top"
    @board = board
    @pos = pos
    @kinged = kinged
  end

  def other_color
    color == :r ? :b : :r
  end

  def perform_slide(dest)
    return false unless board.valid_pos?(dest)
    i1, j1 = pos
    possible_slides = []

    move_diffs.each do |diff|
      i2, j2 = diff
      possible_slides << [(i1 + i2), (j1 + j2)]
    end

    if !board.occupied?(dest) && possible_slides.include?(dest)
      board[pos], board[dest], self.pos = nil, self, dest
    else
      return false
    end
    true
  end

  def perform_jump(dest)
    return false unless board.valid_pos?(dest)
  end



  def move_diffs
    if kinged #kings move everywhere
      MOVE_DIFFS.values
    elsif color == :r #red moves up
      [MOVE_DIFFS[:NE], MOVE_DIFFS[:NW]]
    else #black moves down
      [MOVE_DIFFS[:SE], MOVE_DIFFS[:SW]]
    end
  end

  def render
    if color == :r
      kinged ? ' R ' : ' r '
    else
      kinged ? ' B ' : ' b '
    end
  end


end
