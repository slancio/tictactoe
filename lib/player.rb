class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def move(*args)
    raise "Player::move should not be called"
  end
end

class HumanPlayer < Player
  def self.valid_move?(row, col)
    [row, col].all? { |place| (0..2).include?(place) }
  end

  def initialize(name)
    super(name)
  end

  def move(game, mark)
    while true
      game.show

      row, col = get_move
      if self.class.valid_move?(row, col)
        return [row, col]
      else
        puts "Position not on board\n"
      end
    end
  end

  private

    def get_move
      puts "#{@name}, please mark a space. Format: row,column. (e.g., 0,0 #TOP LEFT, 2,2 #BOTTOM RIGHT)"
      return gets.chomp.split(","),map(&:to_i)      
    end

end

class ComputerPlayer < Player
  def self.names
    ["Tandy 400", "Compy 386", "Lappy 486",
     "Compé", "Lappier", "Roomy-Vac",
     "Grampy Aught-Six", "Compydore 64", "Corpy NT6",
     "Zappy XT6"]
  end

  def initialize
    super(self.class.names.sample)
  end
end
