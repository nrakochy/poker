require_relative '../lib/player'
require_relative '../lib/deck'
require 'pry'
describe Player do
  let(:player){ Player.new(100, 1, @hand_of_cards) }

  before :each do
    @deck = Deck.new.make_deck_of_cards
    @hand_of_cards = {1 => @deck[1], 2 => @deck[2], 3 => @deck[3], 4 => @deck[4], 5=> @deck[5] }
  end

  describe '#discard' do
    it 'removes a card and returns the remaining cards in the poker hand' do
      expect(player.discard(5)).to eq(@deck[5])
    end
  end

  describe '#get_card_from_dealer' do
    it 'adds a card to the hand_of_cards and assigns it a number in the hand_of_cards hash' do
      card = @deck[6]
      player.get_card_from_dealer(card)
      expect(player.hand_of_cards).to eq({ 1 => @deck[1], 2 => @deck[2], 3 => @deck[3], 4 => @deck[4], 5=> @deck[5], 6=> @deck[6] })
    end

    it 'assigns the the number 1 to the first card added to the hand_of_cards hash' do
      new_player = Player.new(100, 1)
      card1 = 'JS'
      new_player.get_card_from_dealer(card1)
      expect(new_player.hand_of_cards).to eq( { 1 => 'JS'} )
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
      expect(player.reveal_hand).to eq({ 1 => @deck[1], 2 => @deck[2], 3 => @deck[3], 4 => @deck[4], 5=> @deck[5] })
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
