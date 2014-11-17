require_relative '../lib/deck'

describe Deck do

  let(:deck){ Deck.new }

  describe '#make_deck_of_cards' do

    it 'creates a deck of card Objects that is 52 cards long' do
      deck.make_deck_of_cards
      expect(deck.full_deck.count).to eq(52)
    end

    it 'returns a Hash' do
      deck.make_deck_of_cards
      expect(deck.full_deck.class).to eq(Hash)
    end

    it 'creates Card Objects' do
      deck.make_deck_of_cards
      expect(deck.full_deck[1].class).to be(Card)
    end

  end
end
