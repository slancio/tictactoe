# Board class to keep track of the game board
# Provides public methods to modify board and inform on board status
class Board
  attr_reader :rows, :marks

  def self.empty_board
    Array.new(3) { Array.new(3) }
  end

  def self.validate_pos(pos)
    fail 'invalid position format' unless pos.length == 2
    fail 'position out of Board range' unless pos.all? { |space| (0..2).include?(space) }
  end

  def initialize(options = {})
    defaults = {
      rows: self.class.empty_board,
      marks: [:x, :o]
    }

    @rows = options[:rows] || defaults[:rows]
    @marks = options[:marks] || defaults[:marks]
  end

  def winner
    (rows + columns + diagonals).each do |triple|
      @marks.each { |mark| return mark if triple == [mark, mark, mark] }
    end

    nil
  end

  def won?
    !winner.nil?
  end

  def tied?
    return false if won?

    @rows.flatten.none?(&:nil?)
  end

  def over?
    won? || tied?
  end

  def [](pos)
    self.class.validate_pos(pos)

    row = pos[0]
    col = pos[1]
    @rows[row][col]
  end

  def []=(pos, mark)
    self.class.validate_pos(pos)
    fail 'mark already placed at position' unless empty_pos?(pos)
    fail 'invalid mark' unless @marks.include?(mark)

    row = pos[0]
    col = pos[1]
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

  def dup
    self.class.new(rows: rows.map(&:dup), marks: marks)
  end

  def render
    ''.tap do |output|
      @rows.each do |row|
        row.each do |mark|
          mark.nil? ? output << ' ' : output << mark.to_s.upcase
        end

        output << "\n"
      end
    end
  end
end
