require 'game'

describe TicTacToe do
  let(:player_x) { Player.new('Fred') }
  let(:player_o) { Player.new('Joe') }
  let(:player_y) { Player.new('Steve') }
  let(:player_z) { Player.new('Laura') }
  let(:won_board) do
    Board.new(rows: [[:x, :x, :x],
                     [:o, :x, :o],
                     [nil, :o, nil]])
  end
  let(:won_game) do
    TicTacToe.new(board: won_board,
                  players: { x: player_x, o: player_o })
  end
  let(:tied_board) do
    Board.new(rows: [[:o, :x, :o],
                     [:x, :o, :x],
                     [:x, :o, :x]])
  end
  let(:tied_game) { TicTacToe.new(board: tied_board) }

  describe '#initialize' do
    it 'sets up the game' do
      board = Board.new
      game = TicTacToe.new(board: board, players: { x: player_x, o: player_o })

      expect(game.board).to eq(board)
      expect(game.players.values).to include(player_x)
      expect(game.players.values).to include(player_o)
      expect(board.marks).to match_array(game.players.keys)
      expect(game.turn_order.first).to eq(:x)
    end

    it 'sets board marks to player marks' do
      game2 = TicTacToe.new(players: { y: player_y, z: player_z })
      expect(game2.board.marks).to match_array(game2.players.keys)
      expect(game2.board.marks).to match_array([:y, :z])
      expect(game2.turn_order.first).to eq(:y)
    end

    it 'can have specified turn order' do
      game3 = TicTacToe.new(players: { y: player_y, z: player_z },
                            turn_order: [:z, :y])
      expect(game3.turn_order.first).to eq(:z)
    end

    it 'has sensible default names and marks' do
      game4 = TicTacToe.new
      expect(game4.board.marks).to match_array([:x, :o])
      names = []
      game4.players.values.each { |player| names << player.name }
      expect(names).to match_array(%w(X O))
    end
  end

  context 'playing the game' do
    it 'stops when the game is over' do
      expect { won_game.play }.to output.to_stdout
      expect(won_game).not_to receive(:play_turn)
    end

    it 'declares the name of the winning player' do
      expect { won_game.play }.to output("Fred won the game!\n").to_stdout
    end

    it 'declares ties' do
      expect { tied_game.play }.to output("No one wins!\n").to_stdout
    end

    it 'knows the #current_player' do
      game = TicTacToe.new
      expect(game.current_player).to eq(game.players[:x])
    end

    it 'changes turn order' do
      game = TicTacToe.new
      game.send(:next_turn)
      expect(game.current_player).to eq(game.players[:o])
    end

    it 'places a mark on a valid move' do
      # Mock a player that returns only [0, 0] move
      class TestPlayer < ComputerPlayer
        def initialize
          super
        end

        def move(_game, _mark)
          [0, 0]
        end
      end

      # Mock a player that returns only [0, 1] move
      class TestPlayer2 < ComputerPlayer
        def initialize
          super
        end

        def move(_game, _mark)
          [0, 1]
        end
      end

      # first player win, first turn
      board = Board.new(rows: [[nil, :x, :x], [:x, :o, :o], [:x, :o, :o]])
      game = TicTacToe.new(board: board,
                           players: { x: TestPlayer.new, o: TestPlayer.new },
                           turn_order: [:x, :o])
      expect { game.play }.to output(/won the game!/).to_stdout

      # second player win, second turn
      board = Board.new(rows: [[nil, nil, :x], [nil, :o, :o], [:x, :o, :o]])
      game = TicTacToe.new(board: board,
                           players: { x: TestPlayer.new, o: TestPlayer2.new },
                           turn_order: [:x, :o])
      expect { game.play }.to output(/won the game!/).to_stdout
    end

    # Output matchers aren't thread safe.
    # This test and others like it will sometimes-pass/sometimes-fail
    # Looking into a better way to test or restructure this code
    #
    # it 'indicates an invalid move' do
    #   class TestPlayer < ComputerPlayer
    #     def initialize
    #       super
    #     end
    #     def move(game, mark)
    #       [0, 0]
    #     end
    #   end
    #   board = Board.new(rows: [[:x, :x, nil], [nil, :o, :o], [:x, :o, :o]])
    #   game = TicTacToe.new(board: board,
    #                        players: { x: TestPlayer.new, o: TestPlayer.new },
    #                        turn_order: [:x, :o])
    #   thread = Thread.new { game.play }
    #   expect { thread.run }.to output(/A mark is already in that space/).to_stdout
    #   thread.kill
    # end
  end

  describe '#show' do
    it 'outputs the board state' do
      new_game = TicTacToe.new
      expect { new_game.show }.to output("   \n   \n   \n").to_stdout
      expect { won_game.show }.to output("XXX\nOXO\n O \n").to_stdout
    end
  end
end
