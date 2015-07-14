require 'game'

describe TicTacToe do
  let(:player_x) { Player.new("Fred") }
  let(:player_o) { Player.new("Joe") }
  let(:player_y) { Player.new("Steve") }
  let(:player_z) { Player.new("Laura") }
  let(:won_board) { Board.new({ rows: [[:x, :x, :x],   [:o, :x, :o],   [nil, :o, nil]] }) }
  let(:won_game) { TicTacToe.new({ board: won_board,
                                   players: { :x => player_x, :o => player_o } }) }
  let(:tied_board) { Board.new({ rows: [[:o, :x, :o],   [:x, :o, :x],   [:x, :o, :x]]   }) }
  let(:tied_game) { TicTacToe.new({ board: tied_board })}

  describe '#initialize' do
    it "sets up the game" do
      board = Board.new()
      game = TicTacToe.new({board: board, players: { :x => player_x, :o => player_o }})

      expect( game.board ).to eq(board)
      expect( game.players.values ).to include(player_x)
      expect( game.players.values ).to include(player_o)
      expect( board.marks ).to match_array(game.players.keys)
      expect( game.turn_order.first ).to eq(:x)
    end

    it "sets board marks to player marks" do
      game2 = TicTacToe.new({players: { :y => player_y, :z => player_z }})
      expect( game2.board.marks ).to match_array(game2.players.keys)
      expect( game2.board.marks ).to match_array([:y, :z])
      expect( game2.turn_order.first ).to eq(:y)
    end

    it "can have specified turn order" do
      game3 = TicTacToe.new({players: { :y => player_y, :z => player_z }, turn_order: [:z, :y]})
      expect( game3.turn_order.first ).to eq(:z)
    end

    it "has sensible default names and marks" do
      game4 = TicTacToe.new
      expect( game4.board.marks).to match_array([:x, :o])
      names = []
      game4.players.values.each { |player| names << player.name }
      expect( names ).to match_array(["X", "O"])
    end
  end

  context 'playing the game' do

    it "stops when the game is over" do
      expect{ won_game.play }.to output.to_stdout
      expect( won_game ).not_to receive(:play_turn)
    end

    it "declares the name of the winning player" do
      expect{ won_game.play }.to output("Fred won the game!\n").to_stdout
    end

    it "declares ties" do
      expect{ tied_game.play }.to output("No one wins!\n").to_stdout
    end
  end

  describe '#show' do
    it "outputs the board state" do
      new_game = TicTacToe.new
      expect{ new_game.show }.to output("   \n   \n   \n").to_stdout
      expect{ won_game.show }.to output("XXX\nOXO\n O \n").to_stdout
    end
  end
end