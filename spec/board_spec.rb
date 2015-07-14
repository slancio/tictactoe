require 'board'

describe Board do
  describe '#initialize' do
    it "initalizes a new empty 3x3 board" do
      empty_board = Board.new
      expect(empty_board.rows.count).to eq(3)
      expect(empty_board.rows.flatten.count).to eq(9)
      expect(empty_board.rows.flatten.compact).to eq([])
    end
  end
end