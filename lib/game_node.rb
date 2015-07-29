# TicTactoeNode class to create possible moves tree
# Provides public method to create children
class TicTacToeNode
  attr_reader :board
  attr_accessor :next_mark, :prev_mark_pos

  def initialize(board, next_mark, prev_mark_pos = nil)
    @board = board
    @next_mark = next_mark
    @prev_mark_pos = prev_mark_pos
  end

  def losing_node?(mark)
    return board.won? && (board.winner != mark) if board.over?

    if @next_mark == mark
      children.all? { |child| child.losing_node?(mark) }
    else
      children.any? { |child| child.losing_node?(mark) }
    end
  end

  def winning_node?(mark)
    return board.winner == mark if board.over?

    if @next_mark == mark
      children.any? { |child| child.winning_node?(mark) }
    else
      children.all? { |child| child.winning_node?(mark) }
    end
  end

  def children
    row_max = @board.rows.length - 1
    col_max = @board.rows.first.length - 1

    [].tap do |children|
      (0..row_max).each do |row_idx|
        (0..col_max).each do |col_idx|
          pos = [row_idx, col_idx]

          next unless board.empty_pos?(pos)

          new_board = board.dup
          new_board[pos] = next_mark
          new_board_mark = @board.marks.reject { |mark| mark == @next_mark }

          children << TicTacToeNode.new(new_board, new_board_mark[0], pos)
        end
      end
    end
  end
end
