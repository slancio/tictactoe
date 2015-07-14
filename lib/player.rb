class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class HumanPlayer < Player
  def initialize(name)
    super(name)
  end
end

class ComputerPlayer < Player
  NAMES = ["Tandy 400", "Compy 386",
           "Lappy 486", "Compé",
           "Lappier", "Roomy-Vac",
           "Grampy Aught-Six", "Compydore 64",
           "Corpy NT6", "Zappy XT6"]

  def initialize
    super(NAMES.sample)
  end
end