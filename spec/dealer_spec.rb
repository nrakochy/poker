require_relative '../lib/dealer'

describe Dealer do
  let(:dealer) { Dealer.new }

  describe '#initialize' do
    it 'initializes with a Hash of Card objects' do
      expect(dealer.current_deck.class).to eq( Hash )
      expect(dealer.current_deck[1].class).to eq( Card  )
    end
  end
end
