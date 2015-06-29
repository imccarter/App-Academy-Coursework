class Tile
  attr_accessor :bombed, :flagged, :revealed, :value

  def initialize(board, value = "0", flagged = false, revealed = false)
    @board = board
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

  def swap_flag
    self.flagged = flagged ? false : true
  end

  def reveal
    self.revealed = true
  end

  def to_s
    if revealed
      value == "0" ? "_" : value
    elsif flagged
      "F"
    else
      "*"
    end
  end

end
