require_relative '../lib/deck'

describe Deck do

  let(:deck){ Deck.new }

  describe '#make_deck_of_cards' do
    it 'creates a deck of card Objects that is 52 cards long' do
      expect(deck.full_deck.count).to eq(52)
    end

    it 'returns a Array' do
      expect(deck.full_deck.class).to eq(Array)
    end

    it 'creates Card Objects' do
      expect(deck.full_deck[1].class).to be(Card)
    end
  end

  describe '#find_card_in_deck' do
    it 'returns a card object based on given rank and suit' do
      card1 = deck.find_card_in_deck("2", "Hearts")
      expect(card1.rank).to eq("2")
      expect(card1.suit).to eq("Hearts")
    end
  end
end
