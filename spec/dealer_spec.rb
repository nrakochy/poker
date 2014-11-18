require_relative '../lib/dealer'

describe Dealer do
  let(:dealer) { Dealer.new }

  describe '#initialize' do
    it 'initializes with a Array of Card objects' do
      expect(dealer.current_deck.class).to eq( Array )
      expect(dealer.current_deck[1].class).to eq( Card  )
    end
  end

  describe '#deal_card' do
    it 'reduces the available deck by 1' do
      dealer.deal_card
      expect(dealer.current_deck.count).to eq( 51 )
    end

    it 'returns a Card object' do
      card1 = dealer.deal_card
      expect(card1.class).to eq(Card)
    end
  end


end
