require_relative 'board'
require_relative 'player'
require_relative 'game_node'

# TicTactoe class to keep track of the game state
# Provides public methods to create game, game loop and inform on game stats
class TicTacToe
  attr_reader :board, :players, :turn_order

  def initialize(options = {})
    if options.keys.include?(:players)
      new_board = Board.new(marks: options[:players].keys)
    else
      new_board = Board.new
    end

    defaults = {
      board: new_board,
      players: { x: Player.new('X'), o: Player.new('O') },
      turn_order: new_board.marks
    }

    @board = options[:board] || defaults[:board]
    @players = options[:players] || defaults[:players]
    @turn_order = options[:turn_order] || defaults[:turn_order]
  end

  def play
    play_turn until @board.over?

    if @board.won?
      winning_player = @players[@board.winner]
      puts "#{winning_player.name} won the game!"
    else
      puts 'No one wins!'
    end
  end

  def current_player
    @players[current_player_mark]
  end

  def current_player_mark
    @turn_order.first
  end

  def show
    puts @board.render
  end

  def empty_spaces
    @board.rows.flatten.count(&:nil?)
  end

  def first_turn?
    empty_spaces == 9 || empty_spaces == 8
  end

  private

  def play_turn
    loop do
      pos = current_player.move(self, current_player_mark)
      break if place_mark(pos, current_player_mark)
    end

    next_turn
  end

  def place_mark(pos, mark)
    if @board.empty_pos?(pos)
      @board[pos] = mark
      true
    else
      puts 'A mark is already in that space'
      false
    end
  end

  def next_turn
    @turn_order.rotate!
  end
end

if __FILE__ == $PROGRAM_NAME
  computer = ComputerPlayer.new
  puts "Play the unbeatable computer, #{computer.name}!"
  puts 'Please enter your name: '
  player_name = gets.chomp
  human = HumanPlayer.new(player_name)

  TicTacToe.new(players: { x: human, o: computer }).play
end
