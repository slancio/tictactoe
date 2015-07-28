require 'game'

describe TicTacToeNode do
  let(:empty_node) do
    TicTacToeNode.new(Board.new, :x)
  end

  let(:first_child_node) do
    TicTacToeNode.new(Board.new(rows: [[:x, nil, nil],
                                       [nil, nil, nil],
                                       [nil, nil, nil]]),
                      :o, [0, 0])
  end

  describe '#initialize' do
    it 'sets up the node' do
      board = Board.new
      mark = :x
      node = TicTacToeNode.new(board, mark)
      expect(node.board).to eq(board)
      expect(node.next_mark).to eq(mark)
    end
  end

  describe '#children' do
    it 'generates as many children as there are empty spaces' do
      expect(empty_node.children.length).to eq(9)
      expect(first_child_node.children.length).to eq(8)
    end

    it 'children have different marks than their parent' do
      expect(empty_node.children.all? do |child|
        child.next_mark == :o
      end).to eq(true)
    end

    it 'child prev_mark_pos equal to parent move' do
      child_prev_moves = empty_node.children.map(&:prev_mark_pos)
      expect(child_prev_moves).to match_array([0, 1, 2].product([0, 1, 2]))
    end

    it 'child boards are dup of parent' do
      child_boards = empty_node.children.map(&:board)
      expect(child_boards.none? do |child_board|
        child_board.object_id == empty_node.board.object_id
      end).to eq(true)
    end
  end
end
