require_relative 'board'
require_relative 'player'


class ChessGame

  CURSOR_VECTORS = { :up => [-1, 0], :down => [1, 0], :left => [0, -1], :right => [0, 1] }

  def initialize(board = Board.new, which_game = board.set_default_board)
    @board = board
  end

  def displace(position, vector)
    displaced_pos = position.dup
    displaced_pos[0] += vector[0]
    displaced_pos[1] += vector[1]
    displaced_pos
  end


  def cursor_navigation

  end

  def piece_loop

  end

  def destination_loop
    cursor_position = [0,0]
    board.possible_moves_display(cursor_position)
    input = read_char
    until input == :return
      input = read_char
      vector = CURSOR_VECTORS[input]
      cursor_position = displace(cursor_position, vector)
      until in_bounds?(result)
        input = read_char
        vector = CURSOR_VECTORS[input]
        cursor_position = displace(currsor_position, vector)
      end
      board.possible_moves_display(cursor_position)
    end
    board.move_piece!(board[*cursor_position])
  end

  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true
    STDIN.cooked!

    return input
  end

  def show_single_key
    c = read_char

    case c
    when "\e[A"
      :up
    when "\e[B"
      :down
    when "\e[C"
      :right
    when "\e[D"
      :left
    when "\r"
      :return
    when /^.$/
      p c.inspect.to_sym
      c.inspect.to_sym
    else
      puts "SOMETHING ELSE: #{c.inspect}"
    end
  end


end
