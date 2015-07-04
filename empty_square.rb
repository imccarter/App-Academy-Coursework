require 'colorize'

class EmptySquare

  attr_reader :pos

  def initialize

  end

  def duper(_)
    self.dup
  end

  def color
    false
  end

  def update_pos(pos)
  end

  def render
    #render background color only
    " "
  end

end
