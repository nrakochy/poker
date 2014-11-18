require_relative '../lib/poker_round'
require_relative '../lib/player'
require_relative '../lib/poker_round_setup'
require_relative '../lib/dealer'

describe PokerRound do
  player1 = Player.new(100, 0)
  player2 = Player.new(100, 1)
  player3 = Player.new(100, 2)
  player4 = Player.new(100, 3)
  setup = PokerRoundSetup.new(10.0, [player1, player2, player3, player4])
  dealer = Dealer.new
  let(:poker_round_with_betting) { PokerRound.new(setup.players_in_the_round, dealer) }
  let(:poker_round) { PokerRound.new([player1, player2, player3, player4], dealer)}

  describe '#add_bet_to_the_pot' do
    it 'raises the amount of the pot by amount bet' do
      poker_round.add_bet_to_the_pot(10)
      expect(poker_round.pot).to eq( 25 )
    end
  end

  describe '#deal_hand_of_cards' do
    it 'reduces the Dealers deck by number of cards dealt' do
      poker_round.deal_hand_of_cards(poker_round.active_players)
      expect(poker_round.dealer.deck.count).to eq(22)
    end
  end





end
