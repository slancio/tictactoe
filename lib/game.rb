require 'board'
require 'player'

class TicTacToe
  attr_reader :board, :players, :turn_order

  def initialize(options = {})
    if options.keys.include?(:players)
      new_board = Board.new({marks: options[:players].keys})
    else
      new_board = Board.new
    end

    defaults = {
      :board => new_board,
      :players => {:x => Player.new("X"), :o => Player.new("O")},
      :turn_order => new_board.marks
    }

    @board = options[:board] || defaults[:board]
    @players = options[:players] || defaults[:players]
    @turn_order = options[:turn_order] || defaults[:turn_order]
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

  def current_player
    @players[@turn_order.first]
  end

  def show
    puts @board.render
  end

  private

    def play_turn
      while true

      end

      next_turn
    end

    def next_turn
      @turn_order.rotate!
    end
end
