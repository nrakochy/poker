require_relative '../lib/dealer'

describe Dealer do
  let(:dealer) { Dealer.new }

  describe '#initialize' do
    it 'initializes with a array of Cards' do
      expect(dealer.current_deck.class).to eq( Array )
      expect(dealer.current_deck[0].class).to eq( Card  )
    end
  end
end
