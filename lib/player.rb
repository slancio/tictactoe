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
  end
end
