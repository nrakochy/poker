require_relative '../lib/player'

describe Player do
  let(:player){ Player.new(100, 1, ['AH', 'AD', 'AS', 'AC', '2H']) }

  describe '#discard' do
    it 'removes a card and returns the remaining cards in the poker hand' do
      expect(player.discard([4])).to eq( ['AH', 'AD', 'AS', 'AC'] )
    end
  end 
  
  describe '#call' do
    it 'reduces the number of available chips by the amount of the current bet' do
      expect(player.call(10)).to eq( 90 )
    end

    it 'reduces the number of available chips by the amount needed to call, subtracting current_bet from amount_already_bet' do
      expect(player.call(10, 5)).to eq( 95 )
    end
  end

  describe '#raise_bet' do
    it 'reduces the number of available chips by the desired amount to raise' do
      expect(player.raise_bet(10)).to eq( 90 )
    end
  end

  describe '#fold' do
    it 'eliminates all of the cards in the players hand' do
      expect(player.fold).to eq( [ ] )
    end
  end

  describe '#call_and_raise' do
    it 'eliminates all of the cards in the players hand' do
      expect(player.call_and_raise(15, 15)).to eq( 70  )
    end
  end

  describe '#reveal_hand' do
    it 'returns the hand of cards' do
      expect(player.reveal_hand).to eq( ['AH', 'AD', 'AS', 'AC', '2H'] )
    end
  end

end
