require_relative '../lib/deck'

describe Deck do

  let(:deck){ Deck.new }

  describe '#make_deck_of_cards' do

    it 'creates a deck of card Objects that is 52 cards long' do
      expect(deck.full_deck.length).to eq(52)
    end

    it 'returns an array' do
      expect(deck.full_deck.class).to eq(Array)
    end

    it 'creates Card Objects' do
      expect(deck.full_deck.first.class).to be(Card)
    end

  end
end
