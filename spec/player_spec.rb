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
