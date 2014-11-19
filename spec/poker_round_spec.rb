require_relative '../lib/poker_round'
require_relative '../lib/player'
require_relative '../lib/poker_round_setup'
require_relative '../lib/dealer'

describe PokerRound do
  before :each do
    player1 = Player.new(100, 0)
    player2 = Player.new(100, 1)
    player3 = Player.new(100, 2)
    player4 = Player.new(100, 3)
    @players = [player1, player2, player3, player4]
    @setup = PokerRoundSetup.new(10.0, @players)
    @dealer = Dealer.new
  end

  let(:poker_round_with_betting) { PokerRound.new(@setup.players_in_the_round, @dealer) }
  let(:poker_round) { PokerRound.new(@players, @dealer)}

  describe '#add_bet_to_the_pot' do
    it 'raises the amount of the pot by amount bet' do
      poker_round.add_bet_to_the_pot(10)
      expect(poker_round.pot).to eq( 25 )
    end
  end

  describe '#deal_hand_of_cards' do
    it 'reduces the Dealers deck by number of cards dealt' do
      poker_round.deal_hand_of_cards(poker_round.active_players)
      expect(poker_round.dealer.current_deck.count).to eq(32)
    end

    it 'adds five cards to a Players hand_of_cards' do
      poker_round.deal_hand_of_cards(poker_round.active_players)
      expect(poker_round.active_players[0].hand_of_cards.count).to eq(5)
    end
  end

end
