class TicTacToeNode
  attr_reader :board, :next_mark, :prev_mark_pos

  def initialize(board, next_mark, prev_mark_pos = nil)
    @board, @next_mark, @prev_mark_pos =
      board, next_mark, prev_mark_pos
  end
end