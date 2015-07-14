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

