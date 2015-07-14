class Board
  attr_reader :rows

  def self.empty_board
    Array.new(3) { Array.new(3) }
  end

  def initialize(rows = self.class.empty_board)
    @rows = rows
  end

  def [](pos)
    raise "invalid position format" unless pos.length == 2
    raise "position out of Board range" unless pos.all? { |axis| axis >= 0 && axis <= 2 }

    row, col = pos[0], pos[1]
    @rows[row][col]
  end
end