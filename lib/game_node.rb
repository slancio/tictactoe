class TicTacToeNode
  attr_reader :board, :next_mark, :prev_mark_pos

  def initialize(board, next_mark, prev_mark_pos = nil)
    @board, @next_mark, @prev_mark_pos =
      board, next_mark, prev_mark_pos
  end

  def losing_node?(mark)
    if board.over?
      return board.won? && (board.winner != mark)
    end

    if @next_mark == mark
      self.children.all? { |child| child.losing_node?(mark) }
    else
      self.children.any? { |child| child.losing_node?(mark) }
    end
  end

  def winning_node?(mark)
    if board.over?
      return board.winner == mark
    end
  end

  def children
    row_max, col_max = @board.rows.length - 1, @board.rows.first.length - 1

    [].tap do |children|
      (0..row_max).each do |row_idx|
        (0..col_max).each do |col_idx|
          pos = [row_idx, col_idx]

          next unless board.empty_pos?(pos)

          new_board = board.dup
          new_board[pos] = self.next_mark
          next_mark = board.marks.rotate.first

          children << TicTacToeNode.new(new_board, next_mark, pos)
        end
      end
    end
  end
end