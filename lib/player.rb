# Player class to play game
# Sets the player's name
class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def move(*_)
    fail 'Player::move should not be called'
  end
end

# extend Player
# HumanPlayer allows a person to person to play game
class HumanPlayer < Player
  def self.valid_move?(row, col)
    [row, col].all? { |place| (0..2).include?(place) }
  end

  def initialize(name)
    super(name)
  end

  def move(game, _)
    loop do
      game.show

      row, col = prompt_move
      if self.class.valid_move?(row, col)
        return [row, col]
      else
        puts "Position not on board\n"
      end
    end
  end

  private

  def prompt_move
    print "#{@name}, please mark a space. Format: row,column."
    print "(e.g., 0,0 #TOP LEFT, 2,2 #BOTTOM RIGHT)\n"
    gets.chomp.split(',').map(&:to_i)
  end
end

# extend Player
# ComputerPlayer provides an unbeatable AI to play game
class ComputerPlayer < Player
  CORNERS = [[0, 0], [0, 2], [2, 0], [2, 2]]
  SIDES = [[0, 1], [1, 0], [1, 2], [2, 1]]

  def self.names
    ['Tandy 400', 'Compy 386', 'Lappy 486',
     'Compé', 'Lappier', 'Roomy-Vac',
     'Grampy Aught-Six', 'Compydore 64', 'Corpy NT6',
     'Zappy XT6']
  end

  def initialize
    super(self.class.names.sample)
  end

  def move(game, mark)
    return play_first_turn(game) if game.first_turn?

    if check_early_fork? game
      second_move = block_corner_fork(game, mark)
      return second_move unless second_move.nil?
    end

    node = TicTacToeNode.new(game.board, mark)
    possible_moves = node.children.shuffle

    # Make any winning move
    node = possible_moves.find { |child| child.winning_node?(mark) }
    return node.prev_mark_pos if node

    # Block an opponent's win
    possible_moves.each do |child|
      child.children.each do |grand_child|
        node = grand_child if grand_child.board.won?
      end
    end
    return node.prev_mark_pos if node

    # Make a non-losing move
    node = possible_moves.find { |child| !child.losing_node?(mark) }
    return node.prev_mark_pos if node

    possible_moves.sample.prev_mark_pos
  end

  private

  def play_first_turn(game)
    # On first move, play a corner
    # If going second, play center unless the center and
    # corners are empty
    if CORNERS.all? { |pos| game.board[pos].nil? } &&
       !game.board[[1,1]].nil?
      return CORNERS.sample
    end

    [1, 1]
  end

  def block_corner_fork(game, mark)
    return nil if game.board[[1, 1]] != mark

    # force opponent to block your win instead of forking you
    if (!game.board[[0, 0]].nil? && !game.board[[2, 2]].nil?) ||
       (!game.board[[0, 2]].nil? && !game.board[[2, 0]].nil?)
      return SIDES.sample
    end

    nil
  end

  def check_early_fork?(game)
    game.empty_spaces == 6
  end
end
