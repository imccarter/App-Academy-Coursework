require_relative 'board'
require 'yaml'

class Game
  attr_reader :board

  def self.load
    puts "Which file would you like to load?"
    filename = gets.chomp
    game = File.open(filename, "r") { |f| YAML::load(f) }
    game.run
  end

  def initialize(size = 9, bombs = 10)
    @board = Board.new(self, size, bombs)
  end

  def run
    start_time = Time.now
    board.render
    until board.over?
      take_turn
    end
    end_time = Time.now
    log_time(end_time - start_time) if board.won?
    finish_game
  end

  def take_turn
    offer_save
    flag_or_reveal == "f" ? flag_turn : reveal_turn
    board.render
  end

  def offer_save
    puts "Would you like to save your game? (y/n)"
    save_game if gets.chomp == "y"
  end

  def save_game
    f = File.open("#{self}", "w") { |f| f.write(self.to_yaml) }

  end

  def flag_or_reveal
    puts "Would you like to place/remove a flag or reveal a tile? (f/r)"
    gets.chomp
  end

  def flag_turn
    puts "Which position would you like to flag or unflag? (e.g. 0,0)"
    pos = gets.chomp.split(",").map(&:to_i)
    board.swap_flag(pos)
  end

  def reveal_turn
    puts "Which position would you like to reveal?"
    pos = gets.chomp.split(",").map(&:to_i)
    board.reveal_tiles(pos)
  end

  def finish_game
    print board.won? ? "You win!" : "You blew up!"
  end

  def log_time(secs)
    leaders = File.readlines("leaderboard.txt").map(&:chomp)
    leaders.map! { |leader| leader.split(": ") }
    unless leaders.all? { |_, time| secs > time.to_f }
      puts "You got a high score! What's your name?"
      name = gets.chomp
      leaders << [name, secs]
      leaders = leaders.sort_by { |_, time| time.to_f }.take(10)
      update_leaderboard(leaders)
    end
  end

  def update_leaderboard(leaders)
    puts "High Scores"
    new_leaderboard = leaders.inject("") { |board, leader| board + leader.join(": ") + "\n" }
    File.open("leaderboard.txt", "w") { |f| f.write(new_leaderboard) }
    puts new_leaderboard
  end
end
