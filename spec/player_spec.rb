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

  describe '#initialize' do
    it "has a name" do
      expect(ComputerPlayer::names).to include(test_computer.name)
    end
  end
end
