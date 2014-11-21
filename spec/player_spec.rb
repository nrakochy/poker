require_relative '../lib/player'
require_relative '../lib/deck'
require 'pry'

describe Player do

  let(:player){ Player.new(100, 1, 1, @hand_of_cards) }

  before :each do
    deck = Deck.new
    @hand_of_cards = [
      deck.find_card_in_deck("A", "Hearts"), deck.find_card_in_deck("A", "Spades"),
      deck.find_card_in_deck("A", "Diamonds"), deck.find_card_in_deck("A", "Clubs"),
      deck.find_card_in_deck("2", "Spades")
    ]
  end

  describe '#discard' do
    it 'removes a card and returns the remaining cards in the poker hand' do
      spades2 = @hand_of_cards[4]
      expect(player.discard(spades2)).to eq(spades2)
    end
  end

  describe '#get_card_from_dealer' do
    it 'adds a card to the players hand of cards' do
      clubs3 = Deck.new.find_card_in_deck("3", "Clubs")
      player.get_card_from_dealer(clubs3)
      expect(player.hand_of_cards.last).to eq(clubs3)
    end

    it 'updates the hand_value attribute when the player gets a card from the dealer and has 5 cards in hand ' do
      clubs2 = Deck.new.find_card_in_deck("2", "Clubs")
      ace_hearts = @hand_of_cards[0]
      player.discard(ace_hearts)
      player.get_card_from_dealer(clubs2)
      expect(player.hand_value).to eq("Full House")
    end
  end


  describe '#call' do
    it 'reduces the number of available chips by the amount of the current bet' do
      expect(player.call(10)).to eq( 90 )
    end

    it 'increases the attribute already_placed_bet by the call amount' do
      player.call(10)
      expect(player.already_placed_bet).to eq(10)
    end


    it 'reduces the number of available chips by the amount needed to call, subtracting current_bet from amount_already_bet' do
      first_placed_bet = 10
      total_current_bet = 15
      player.call(first_placed_bet)
      expect(player.call(total_current_bet)).to eq( 85 )
    end

    it 'increases the amount_already_bet by the amount needed to call in a subsequent call-raise sequence' do
      first_placed_bet = 10
      total_current_bet = 15
      player.call(first_placed_bet)
      player.call(total_current_bet)
      expect(player.already_placed_bet).to eq( 15 )
    end

  end

  describe '#raise_bet' do
    it 'reduces the number of available chips by the desired amount to raise' do
      player.raise_bet(10)
      expect(player.available_chips).to eq( 90 )
    end

    it 'returns the amount of the desired bet' do
      expect(player.raise_bet(10)).to eq( 10 )
    end

    it 'increases the attribute already_placed_bet by the call amount' do
      player.raise_bet(10)
      expect(player.already_placed_bet).to eq(10)
    end

  end

  describe '#fold' do
    it 'eliminates all of the cards in the players hand' do
      expect(player.fold).to eq( [ ] )
    end
  end

  describe '#call_and_raise' do
    it 'reduces the number of chips that a player has by the amount to call + amount to raise' do
      player.call_and_raise(15, 15)
      expect(player.available_chips).to eq( 70 )
    end

    it 'decreases the amount needed to call/raise by the amount which has already been placed as a bet' do
      player.call(10)
      player.call_and_raise(15, 10)
      expect(player.available_chips).to eq( 75 )
    end

    it 'increases the amount_already_bet by the difference between existing amount_already_bet and call/raise amount ' do
      player.call(10)
      player.call_and_raise(15, 10)
      expect(player.already_placed_bet).to eq(25)
    end
  end

  describe '#reveal_hand' do
    it 'returns the hand of cards' do
      expect(player.reveal_hand).to eq(@hand_of_cards)
    end
  end

  describe '#reset_already_placed_bet_at_end_of_betting' do
    it 'resets already_placed_bet to 0' do
      player.call(10)
      player.reset_already_placed_bet_at_end_of_betting
      expect(player.already_placed_bet).to eq( 0 )
    end
  end

end
