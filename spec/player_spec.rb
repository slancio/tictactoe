require 'player'

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
      expect{ test_player.move([0, 0], :x) }.to raise_error("Player::move should not be called")
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
