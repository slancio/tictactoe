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
      expect( empty_node.children.length ).to eq(9)
      expect( first_child_node.children.length ).to eq(8)
    end

    it "children have different marks than their parent" do
      expect( empty_node.children.all? do |child|
        child.next_mark == :o
      end ).to eq(true)
    end

    it "children's prev_mark_pos equal to parent's move" do
      child_prev_moves = empty_node.children.map{ |child| child.prev_mark_pos }
      expect( child_prev_moves ).to match_array([0,1,2].product([0,1,2]))
    end

    it "children's boards are dup of parent's" do
      child_boards = empty_node.children.map { |child| child.board }
      expect( child_boards.none? do |child_board|
        child_board.object_id == empty_node.board.object_id
      end ).to eq(true)
    end
  end

  describe '#winning_node?' do

  end

  describe '#losing_node?' do
    it "knows when a node is in a losing state" do
      empty_node.board[[0,0]] = :o
      empty_node.board[[0,1]] = :o
      empty_node.board[[0,2]] = :o
      expect( empty_node.losing_node?(:o) ).to eq(false)
      expect( empty_node.losing_node?(:x) ).to eq(true)
    end

    let(:loser) do
      node = TicTacToeNode.new(Board.new, :x)
      node.board[[0,0]] = :o
      node.board[[0,2]] = :o
      node.board[[2,2]] = :o
      node
    end

    let(:opponent_wins) do
      node = TicTacToeNode.new(Board.new, :o)
      node.board[[0, 0]] = :x
      node.board[[0, 1]] = :x
      node.board[[0, 2]] = :o
      node.board[[1, 1]] = :o
      node.board[[1, 0]] = :x
      node
    end

    context "on the player's turn" do
      it "knows when every child is in losing state" do
        expect( loser.losing_node?(:x) ).to eq(true)
      end
    end

    context "on the opponent's turn" do
      it "knows when every child is in losing state" do
        expect( loser.losing_node?(:o) ).to eq(false)
        expect( opponent_wins.losing_node?(:x) ).to eq(true)
      end
    end
  end
end