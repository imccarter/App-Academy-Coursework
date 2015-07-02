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

  def perform_slide(dest)
    return false unless board.valid_pos?(dest)
    i1, j1 = pos
    move_diffs.each do |diff|
      i2, j2 = diff
      true if dest == [(i1 + i2), (j1 + j2)]
    end
    board[pos] = nil
    board[dest] = self
    self.pos = dest
  end

  def perform_jump

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
