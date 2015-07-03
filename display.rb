require_relative 'board'
require 'io/console'

class Display

  def initialize

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
    pos = [0, 0]
    c = read_char
    case c
    when "\e[A"
      # puts "UP ARROW"
      pos[0] -= 1
    when "\e[B"
      # puts "DOWN ARROW"
      pos[0] += 1
    when "\e[C"
      # puts "RIGHT ARROW"
      pos[1] += 1
    when "\e[D"
      # puts "LEFT ARROW"
      pos[1] -= 1

    end
  end

end
