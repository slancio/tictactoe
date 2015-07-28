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
    @mark = nil
  end

  def move(game, mark)
    @mark = mark if @mark.nil?

    node = TicTacToeNode.new(game.board, @mark)
    find_best_move(node)
  end

  private

  def find_best_move(node)
    scores = {}

    node.children.each do |child|
      scores[child.prev_mark_pos] = minimax(child, 0)
    end

    max_score = scores.values.max
    scores.key max_score
  end

  def score(board, depth)
    return 0 unless board.won?

    board.winner == @mark ? 10 - depth : depth - 10
  end

  def minimax(node, depth)
    return score(node.board, depth) if node.board.over?
    scores = []

    # Traverse and score the tree (score leaf nodes)
    node.children.each do |child|
      scores << minimax(child, depth + 1)
    end

    # Min/Max Calculation
    node.next_mark == @mark ? scores.max : scores.min
  end
end
