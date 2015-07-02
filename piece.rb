class Piece

  attr_reader :color, :board, :pos, :kinged

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

  def perform_slide

  end

  def perform_jump

  end

  def move_diffs
    if kinged
      MOVE_DIFFS.values
    elsif color == :r
      MOVE_DIFFS[:NE] + MOVE_DIFFS[:NW]
    else
      MOVE_DIFFS[:NE] + MOVE_DIFFS[:NW]
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
