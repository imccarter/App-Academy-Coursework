require_relative 'tile.rb'

class Board
  attr_accessor :grid
  attr_reader :bombs, :size
  ADJ_POS = [
    [-1, -1], [-1 , 0],
    [-1, 1], [0, -1],
    [0, 1], [1, -1],
    [1, 0], [1, 1]
            ]

  def initialize(game = nil, size = 9, bombs = 10)
    @game = game
    @size = size
    @bombs = bombs
    @grid = Array.new(size) { Array.new(size) {Tile.new(self)} }
    add_bombs
    update_values
  end

  def add_bombs
    bomb_positions = []

    until bomb_positions.length == bombs
      position = []
      position[0] = rand(0...size)
      position[1] = rand(0...size)
      bomb_positions << position unless bomb_positions.include?(position)
    end

    bomb_positions.each do |bomb_position|
      self[bomb_position].bomb
    end
  end

  def update_values
    (0...size).each do |row_idx|
      (0...size).each do |col_idx|
        pos = [row_idx, col_idx]
        if !self[pos].bombed?
          bomb_count = 0
          adj_positions(pos).each { |adj| bomb_count += 1 if !off_board?(adj) && self[adj].bombed? }
          self[pos].value = bomb_count.to_s
        end
      end
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    @grid[row][col] = mark
  end

  def adj_positions(pos)
    ADJ_POS.map { |adj| [pos[0] + adj[0], pos[1] + adj[1]] }
  end

  def reveal_tiles(pos, first = true, checked_positions = [])
    #maybe avoid repeating tile checks
    return nil if off_board?(pos) || checked_positions.include?(pos)
    game.lose if self[pos].bombed?
    puts pos.to_s
    puts "i'm revealing #{pos}"
    self[pos].reveal
    checked_positions << pos
    if self[pos].value == "0"
      adj_positions(pos).each do |adj|
        reveal_tiles(adj, false, checked_positions) if !off_board?(adj)
      end
    end
  end

  def off_board?(pos)
    !((0...size).include?(pos[0]) && (0...size).include?(pos[1]))
  end

  def render
    @grid.each do |row|
      printable = []
      row.each { |tile| printable << tile.to_s }
      puts printable.join(" ")
    end
  end

end
