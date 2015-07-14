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

    it "sets the mark at a coordinate" do
      sample_board[[1,0]] = :x
      sample_board[[1,2]] = :o
      sample_board[[2,2]] = :x

      expect( sample_board[[1,0]] ).to eq(:x)
      expect( sample_board[[1,2]] ).to eq(:o)
      expect( sample_board[[2,2]] ).to eq(:x)
    end

    it "raises an error on invalid positions" do
      expect { sample_board[[1]] }.to raise_error("invalid position format")
      expect { sample_board[[1,2,3]] }.to raise_error("invalid position format")
      expect { sample_board[[0,3]] }.to raise_error("position out of Board range")
      expect { sample_board[[3,0]] }.to raise_error("position out of Board range")
      expect { sample_board[[-3, 1]] }.to raise_error("position out of Board range")

      expect { sample_board[[1]] = :x }.to raise_error("invalid position format")
      expect { sample_board[[1,2,3]] = :o }.to raise_error("invalid position format")
      expect { sample_board[[0,3]] =  :x }.to raise_error("position out of Board range")
      expect { sample_board[[3,0]] = :o }.to raise_error("position out of Board range")
      expect { sample_board[[-3, 1]] = nil }.to raise_error("position out of Board range")

      expect { sample_board[[0,0]] = :o }.to raise_error("mark already placed at position")
    end
  end
end