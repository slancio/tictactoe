require 'game'

describe TicTacToe do
  describe '#initialize' do
    it "sets up the game" do
      player_x = Player.new("Fred")
      player_o = Player.new("Joe")
      board = Board.new()
      game = TicTacToe.new({board: board, players: { :x => player_x, :o => player_o }})

      expect(game.board).to eq(board)
      expect(game.players.values).to include(player_x)
      expect(game.players.values).to include(player_o)
      expect(board.marks).to match_array(game.players.keys)

      player_y = Player.new("Steve")
      player_z = Player.new("Laura")
      game2 = TicTacToe.new({players: { :y => player_y, :z => player_z }})
      expect(game2.board.marks).to match_array(game2.players.keys)
      expect(game2.board.marks).to match_array([:y, :z])
    end
  end

  describe '#show' do
  end
end