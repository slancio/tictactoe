require 'game'

describe TicTacToeNode do
  let(:empty_node) do
    TicTacToeNode.new(Board.new, :x)
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
end