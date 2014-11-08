require_relative '../lib/poker_round'
require_relative '../lib/player'
require_relative '../lib/poker_round_setup'

describe PokerRound do
  player1 = Player.new(100, 0)
  player2 = Player.new(100, 1)
  player3 = Player.new(100, 2)
  player4 = Player.new(100, 3)
  setup = PokerRoundSetup.new(10.0, [player1, player2, player3, player4])
  let(:poker_round) { PokerRound.new(setup) }

  describe '#add_current_bet_to_the_pot' do
    it 'raises the amount of the pot by amount bet' do
      poker_round.add_current_bet_to_the_pot(10)
      expect(poker_round.pot).to eq( 25 )
    end
  end



end
