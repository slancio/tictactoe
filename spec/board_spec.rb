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

  context 'checking winning positions' do
    let(:winning_row_one)   {Board.new( [[:x, :x, :x],   [:o, :x, :o],   [nil, :o, nil]] )}
    let(:winning_row_two)   {Board.new( [[:x, :o, :x],   [:o, :o, :o],   [:x, :nil, :x]] )}
    let(:winning_row_three) {Board.new( [[:o, :nil, :o], [:o, :x, :o],   [:x, :x, :x]]   )}
    let(:winning_col_one)   {Board.new( [[:x, :o, :x],   [:x, nil, :o],  [:x, nil, nil]] )}
    let(:winning_col_two)   {Board.new( [[nil, :o, :x],  [:x, :o, nil],  [nil, :o, nil]] )}
    let(:winning_col_three) {Board.new( [[:x, :o, :x],   [:o, :x, :x],   [:o, :x, :x]]   )}
    let(:winning_diag_one)  {Board.new( [[:x, :o, nil],  [nil, :x, nil], [:o, :x, :x]]   )}
    let(:winning_diag_two)  {Board.new( [[:o, nil, :x],  [:o, :x, :x],   [:x, :o, nil]]  )}
    
    it "returns #rows" do
      expect( sample_board.rows ).to eq([[:x, :o, :x],
                                         [nil, :o, nil],
                                         [nil, :x, nil]])
    end

    it "returns #columns" do
      expect( sample_board.columns ).to eq([[:x, nil, nil],
                                            [:o, :o, :x],
                                            [:x, nil, nil]])
    end

    it "returns #diagonals" do
      expect( sample_board.diagonals ).to eq([[:x, :o, nil],
                                              [nil, :o, :x]])
    end

    it "returns a #winner" do
      expect( winning_row_one.winner ).to eq(:x)
      expect( winning_row_two.winner ).to eq(:o)
      expect( winning_row_three.winner ).to eq(:x)
      expect( winning_col_one.winner ).to eq(:x)
      expect( winning_col_two.winner ).to eq(:o)
      expect( winning_col_three.winner ).to eq(:x)
      expect( winning_diag_one.winner ).to eq(:x)
      expect( winning_diag_two.winner ).to eq(:x)
      expect( sample_board.winner ).to eq(nil)
    end
  end
end