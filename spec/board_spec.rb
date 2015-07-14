require 'board'

describe Board do
  let(:sample_board) do
    Board.new([[:x, :o, :x],
               [nil, :o, nil],
               [nil, :x, nil]])
  end
  
  describe '#initialize' do
    it "initalizes a new empty 3x3 board" do
      empty_board = Board.new
      expect( empty_board.rows.count ).to eq(3)
      expect( empty_board.rows.flatten.count ).to eq(9)
      expect( empty_board.rows.flatten.compact ).to eq([])
    end
  end

  context 'working with positions' do
    it "returns the mark at a coordinate" do
      expect( sample_board[[0,0]] ).to eq(:x)
      expect( sample_board[[1,1]] ).to eq(:o)
      expect( sample_board[[2,2]] ).to eq(nil)
    end

    it "raises an error on invalid positions" do
      expect { sample_board[[1]] }.to raise_error("invalid position format")
      expect { sample_board[[1,2,3]] }.to raise_error("invalid position format")
      expect { sample_board[[0,3]] }.to raise_error("position out of Board range")
      expect { sample_board[[3,0]] }.to raise_error("position out of Board range")
      expect { sample_board[[-3, 1]] }.to raise_error("position out of Board range")
    end
  end
end