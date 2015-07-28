require 'board'

describe Board do
  let(:sample) do
    Board.new(rows: [[:x, :o, :x],
                     [nil, :o, nil],
                     [nil, :x, nil]])
  end

  describe '#initialize' do
    it 'initalizes a new empty 3x3 board' do
      empty_board = Board.new
      expect(empty_board.rows.count).to eq(3)
      expect(empty_board.rows.flatten.count).to eq(9)
      expect(empty_board.rows.flatten.compact).to eq([])
    end
  end

  describe '#dup' do
    let(:duped_sample) do
      sample.dup
    end

    it 'returns a deep_duped Board object' do
      expect(sample.rows).to eq(duped_sample.rows)
      expect(sample).not_to eq(duped_sample)
    end
  end

  context 'working with positions' do
    it 'returns the mark at a coordinate' do
      expect(sample[[0, 0]]).to eq(:x)
      expect(sample[[1, 1]]).to eq(:o)
      expect(sample[[2, 2]]).to be_nil
    end

    it 'sets the mark at a coordinate' do
      sample[[1, 0]] = :x
      sample[[1, 2]] = :o
      sample[[2, 2]] = :x

      expect(sample[[1, 0]]).to eq(:x)
      expect(sample[[1, 2]]).to eq(:o)
      expect(sample[[2, 2]]).to eq(:x)
    end

    it 'raises an error on invalid positions' do
      expect { sample[[1]] }.to raise_error('invalid position format')
      expect { sample[[1, 2, 3]] }.to raise_error('invalid position format')
      expect { sample[[0, 3]] }.to raise_error('position out of Board range')
      expect { sample[[3, 0]] }.to raise_error('position out of Board range')
      expect { sample[[-3, 1]] }.to raise_error('position out of Board range')

      expect { sample[[1]] = :x }.to raise_error('invalid position format')
      expect { sample[[1, 2, 3]] = :o }.to raise_error('invalid position format')
      expect { sample[[0, 3]] =  :x }.to raise_error('position out of Board range')
      expect { sample[[3, 0]] = :o }.to raise_error('position out of Board range')
      expect { sample[[-3, 1]] = nil }.to raise_error('position out of Board range')

      expect { sample[[0, 0]] = :o }.to raise_error('mark already placed at position')
    end
  end

  context 'working with marks' do
    let(:crazy) do
      Board.new(marks: [:y, :z])
    end

    it 'sets correct marks' do
      sample[[1, 2]] = :x
      crazy[[1, 2]] = :y
      expect(sample[[1, 2]]).to eq(:x)
      expect(crazy[[1, 2]]).to eq(:y)
    end

    it 'raises an error on invalid marks' do
      expect { sample[[1, 2]] = :y }.to raise_error('invalid mark')
      expect { crazy[[1, 2]] = :x }.to raise_error('invalid mark')
    end
  end

  context 'checking winning positions' do
    let(:winning_row_one)   { Board.new(rows: [[:x, :x, :x],   [:o, :x, :o],   [nil, :o, nil]])}
    let(:winning_row_two)   { Board.new(rows: [[:x, :o, :x],   [:o, :o, :o],   [:x, :nil, :x]])}
    let(:winning_row_three) { Board.new(rows: [[:o, :nil, :o], [:o, :x, :o],   [:x, :x, :x]])}
    let(:winning_col_one)   { Board.new(rows: [[:x, :o, :x],   [:x, nil, :o],  [:x, nil, nil]])}
    let(:winning_col_two)   { Board.new(rows: [[nil, :o, :x],  [:x, :o, nil],  [nil, :o, nil]])}
    let(:winning_col_three) { Board.new(rows: [[:x, :o, :x],   [:o, :x, :x],   [:o, :x, :x]])}
    let(:winning_diag_one)  { Board.new(rows: [[:x, :o, nil],  [nil, :x, nil], [:o, :x, :x]])}
    let(:winning_diag_two)  { Board.new(rows: [[:o, nil, :x],  [:o, :x, :x],   [:x, :o, nil]])}
    let(:tied_board)        { Board.new(rows: [[:o, :x, :o],   [:x, :o, :x],   [:x, :o, :x]])}

    it 'returns #rows' do
      expect(sample.rows).to eq([[:x, :o, :x],
                                 [nil, :o, nil],
                                 [nil, :x, nil]])
    end

    it 'returns #columns' do
      expect(sample.columns).to eq([[:x, nil, nil],
                                    [:o, :o, :x],
                                    [:x, nil, nil]])
    end

    it 'returns #diagonals' do
      expect(sample.diagonals).to eq([[:x, :o, nil],
                                      [nil, :o, :x]])
    end

    it 'returns a #winner' do
      expect(winning_row_one.winner).to eq(:x)
      expect(winning_row_two.winner).to eq(:o)
      expect(winning_row_three.winner).to eq(:x)
      expect(winning_col_one.winner).to eq(:x)
      expect(winning_col_two.winner).to eq(:o)
      expect(winning_col_three.winner).to eq(:x)
      expect(winning_diag_one.winner).to eq(:x)
      expect(winning_diag_two.winner).to eq(:x)
      expect(sample.winner).to be_nil
      expect(tied_board.winner).to be_nil
    end

    it 'can be won?' do
      expect(sample.won?).to eq(false)
      expect(winning_row_one.won?).to eq(true)
    end

    it 'can be tied?' do
      expect(winning_diag_one.tied?).to eq(false)
      expect(tied_board.tied?).to eq(true)
    end

    it 'can be over?' do
      expect(sample.over?).to eq(false)
      expect(tied_board.over?).to eq(true)
      expect(winning_col_three.over?).to eq(true)
    end
  end

  describe '#render' do
    it 'renders the board' do
      expect(sample.render).to eq("XOX\n O \n X \n")
    end
  end
end
