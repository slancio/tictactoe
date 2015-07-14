class Board
  attr_accessor :rows

  def self.empty_board
    Array.new(3) { Array.new(3) }
  end

  def initialize(rows = self.class.empty_board)
    @rows = rows
  end
end