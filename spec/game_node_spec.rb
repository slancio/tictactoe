require 'game'

describe TicTacToeNode do
  let(:empty_node) do
    TicTacToeNode.new(Board.new, :x)
  end

  let(:first_child_node) do
    TicTacToeNode.new(Board.new({ rows: [[:x, nil, nil],
                                        [nil, nil, nil],
                                        [nil, nil, nil]]}),
                      :o, [0, 0])
  end

  describe '#initialize' do
    it "sets up the node" do
      board = Board.new
      mark = :x
      node = TicTacToeNode.new(board, mark)
      expect( node.board ).to eq(board)
      expect( node.next_mark ).to eq(mark)
    end
  end

  describe '#children' do
    it "generates as many children as there are empty spaces" do
      expect(empty_node.children.length).to eq(9)
      expect(first_child_node.children.length).to eq(8)
    end
  end
end