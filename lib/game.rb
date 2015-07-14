require 'board'
require 'player'

class TicTacToe
  attr_reader :board, :players

  def initialize(options = {})
    if options.keys.include?(:players)
      new_board = Board.new({marks: options[:players].keys})
    else
      new_board = Board.new
    end

    defaults = {
      :board => new_board,
      :players => {:x => Player.new("X"), :y => Player.new("Y")}
    }

    @board = options[:board] || defaults[:board]
    @players = options[:players] || defaults[:players]
  end

  def show
    @board.render
  end
end
