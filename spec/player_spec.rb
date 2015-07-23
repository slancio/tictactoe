require 'game'

describe Player do
  let(:test_player) do
    Player.new("test")
  end

  describe '#initialize' do
    it "has a name" do
      expect( test_player.name ).to eq("test")
    end
  end

  describe '#move' do
    it "raises an error when called" do
      expect{ test_player.move }.to raise_error("Player::move should not be called")
      expect{ test_player.move["fhqwhgads"] }.to raise_error("Player::move should not be called")
      expect{ test_player.move(TicTacToe.new, :x) }.to raise_error("Player::move should not be called")
    end
  end
end

describe HumanPlayer do
  let(:test_human) do
    HumanPlayer.new("User")
  end

  describe '#initialize' do
    it "has a name" do
      expect( test_human.name ).to eq("User")
    end
  end

  # Output matchers aren't thread safe.
  # This test and others like it will sometimes-pass/sometimes-fail
  # Looking into a better way to test or restructure this code 
  # 
  # context 'marking a space' do
  #   let(:test_game) { TicTacToe.new({players: {:x => test_human, :o => HumanPlayer.new("Bob")}})}
  #   let(:test_thread) { Thread.new { test_human.move(test_game, :x) } }
  #
  #   it "displays game state when making a #move" do
  #     expect{ test_thread.run }.to output(/   \n   \n   \n/).to_stdout
  #     test_thread.kill
  #   end
  #
  #   it "requests a move from the player" do
  #     expect{ test_thread.run }.to output(/, please mark a space. Format: row,column./).to_stdout    
  #     test_thread.kill
  #   end
  #
  #   it "indicates a move out of range" do
  #   end
  # end
end

describe ComputerPlayer do
  let(:test_computer) do
    ComputerPlayer.new
  end

  let(:winnable) do
    test_board = Board.new
    test_board[[0,0]] = :x
    test_board[[0,1]] = :x
    test_board[[1,0]] = :o
    test_board[[1,1]] = :o
    double("TicTacToe", :board => test_board, :empty_spaces => 5)
  end
  let(:blockable_win) do
    test_board = Board.new
    test_board[[0,0]] = :x
    test_board[[1,0]] = :o
    test_board[[1,1]] = :o
    double("TicTacToe", :board => test_board, :turn_order => [:x, :o], :empty_spaces => 6)
  end
  # See note @ test below
  # let(:non_winnable) do
  #   test_board = Board.new
  #   test_board[[0,0]] = :o
  #   test_board[[2,2]] = :o
  #   test_board[[2,0]] = :o
  #   double("TicTacToe", :board => test_board, :turn_order => [:x, :o])
  # end
  let(:two_move_victory) do
    test_board = Board.new
    test_board[[0,0]] = :x
    test_board[[2,2]] = :x
    test_board[[1,1]] = :o
    double("TicTacToe", :board => test_board, :turn_order => [:x, :o], :empty_spaces => 6)
  end
  let(:non_losing) do
    test_board = Board.new
    test_board[[0,0]] = :x
    test_board[[1,1]] = :o
    double("TicTacToe", :board => test_board, :turn_order => [:x, :o], :empty_spaces => 7)
  end

  describe '#initialize' do
    it "has a name" do
      expect(ComputerPlayer::names).to include(test_computer.name)
    end
  end

  describe '#move' do
    it "always chooses an available winning move" do
      expect( winnable ).to receive(:first_turn?).and_return(false)
      expect( test_computer.move(winnable, :x) ).to eq([0, 2])
    end

    it "picks winners that are two moves away" do
      expect( two_move_victory ).to receive(:first_turn?).and_return(false)
      move = test_computer.move(two_move_victory, :x)
      expected_moves = [[0, 2], [2, 0]]
      expect( expected_moves.find(move) ).to_not be_nil
    end

    it "blocks opponent's winning moves" do
      expect( blockable_win ).to receive(:first_turn?).and_return(false)
      expect( test_computer.move(blockable_win, :x) ).to eq([1,2])
    end

    it "picks a random move if none are winning or losing" do
      expect( non_losing ).to receive(:first_turn?).and_return(false)
      move = test_computer.move(non_losing, :x)
      expected_moves = [[0, 1], [0, 2], [1, 0], [1, 2], [2,0], [2,1], [2, 2]]
      expect( expected_moves.find(move) ).to_not be_nil
    end

    # With the way that opponent blocking is written, this can
    # no longer be tested. Considering a refactor to make this
    # testable.
    # 
    # it "raises an error if it cannot find a win or draw" do
    #   expect{ test_computer.move(non_winnable, :x) }.to raise_error("Wait, it looks like I'm going to lose?")
    # end
  end
end
