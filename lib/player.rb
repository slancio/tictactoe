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
  NAMES = ["Tandy 400", "Compy 386"]

  def initialize
    super(NAMES.sample)
  end
end