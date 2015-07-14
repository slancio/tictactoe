class Board
  attr_reader :rows

  def self.empty_board
    Array.new(3) { Array.new(3) }
  end

  def self.validate_pos(pos)
    raise "invalid position format" unless pos.length == 2
    raise "position out of Board range" unless pos.all? { |axis| axis >= 0 && axis <= 2 }
  end

  def initialize(rows = self.class.empty_board)
    @rows = rows
  end

  def [](pos)
    self.class.validate_pos(pos)

    row, col = pos[0], pos[1]
    @rows[row][col]
  end

  def []=(pos, mark)
    self.class.validate_pos(pos)
    raise "mark already placed at position" unless empty_pos?(pos)
    
    row, col = pos[0], pos[1]
    @rows[row][col] = mark
  end

  def empty_pos?(pos)
    self[pos].nil?
  end

  def columns
    @rows.transpose
  end

  def diagonals
    down_diag = [[0, 0], [1, 1], [2, 2]]
    up_diag = [[2, 0], [1, 1], [0, 2]]

    [down_diag, up_diag].map { |diag| diag.map { |row, col| @rows[row][col] } }
  end

  def winner
    (rows + columns + diagonals).each do |triple|
      return :x if triple == [:x, :x, :x]
      return :o if triple == [:o, :o, :o]
    end

    nil
  end
end