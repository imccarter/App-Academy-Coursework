class Tile
  ADJ_POS = [
    [-1, -1],
    [-1 , 0],
    [-1, 1],
    [0, -1],
    [0, 1],
    [1, -1],
    [1, 0],
    [1, 1]
  ]
  attr_accessor :flagged, :revealed, :value
  attr_reader :board, :pos

  def initialize(board, pos, value = "0", flagged = false, revealed = false)
    @board = board
    @pos = pos
    @value = value
    @flagged = flagged
    @revealed = revealed
  end

  def bomb
    self.value = "B"
  end

  def bombed?
    value == "B"
  end

  def flagged?
    flagged
  end

  def revealed?
    revealed
  end

  def swap_flag
    self.flagged = flagged ? false : true
  end

  def reveal
    self.revealed = true
  end

  def to_s
    if revealed?
      value == "0" ? "_" : value
    elsif flagged
      "F"
    else
      "*"
    end
  end

  def adj_positions
    ADJ_POS.map { |adj| [pos[0] + adj[0], pos[1] + adj[1]] }
  end
end
