require 'board'
require 'player'

class TicTacToe
  attr_reader :board, :players, :turn

  def initialize(options = {})
    if options.keys.include?(:players)
      new_board = Board.new({marks: options[:players].keys})
      first_turn = options[:players].keys.first
    else
      new_board = Board.new
      first_turn = :x
    end

    defaults = {
      :board => new_board,
      :players => {:x => Player.new("X"), :y => Player.new("Y")},
      :turn => first_turn
    }

    @board = options[:board] || defaults[:board]
    @players = options[:players] || defaults[:players]
    @turn = options[:turn] || defaults[:turn]
  end

  def play
    until @board.over?
      play_turn
    end

    if @board.won?
      winning_player = @players[@board.winner]
      puts "#{winning_player.name} won the game!"
    else
      puts "No one wins!"
    end
  end

  def show
    puts @board.render
  end
end
