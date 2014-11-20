require_relative '../lib/poker_round_setup'
require_relative '../lib/player'

describe PokerRoundSetup do
  before :each do  
    @players= [Player.new(100, 1), Player.new(100, 2), Player.new(100, 3), Player.new(100, 4)]
  end

  let(:poker_round) { PokerRoundSetup.new(10.0, [@players[0], @players[1], @players[2], @players[3]]) }
  let(:three_player_round) { PokerRoundSetup.new(10.0, [@players[0], @players[1], @players[2]]) }
  let(:two_player_round) { PokerRoundSetup.new(10.0, [@players[0], @players[1]]) }

  describe '#bettor_seats_at_the_table' do
    it 'returns an array with number of players whose position at the table is not a blind or dealer position' do
      expect(poker_round.bettor_seats_at_the_table).to eq([4])
    end

    it 'returns nil if less than 4 players at the table' do
      expect(three_player_round.bettor_seats_at_the_table).to eq(nil)
    end
  end

  describe '#identify_table_positions' do
    it 'returns a hash with the table_position as key and associated constant identifying betting amount to start the turn' do
      expect(poker_round.identify_table_betting_positions(poker_round.players_in_the_round)).to eq({1=> 0, 2=> 5, 3=> 10, 4=> 0})
    end

    it 'returns a hash with table_positions for less than 4 players' do
      expect(three_player_round.identify_table_betting_positions(three_player_round.players_in_the_round)).to eq({1=> 0, 2=> 5, 3=> 10 })
    end

    it 'returns a hash with table_positions with only two players, only small blind and big_blind positions' do
      expect(two_player_round.identify_table_betting_positions(two_player_round.players_in_the_round)).to eq({1=> 5, 2=> 10})
    end

    it 'assigns the table_positions upon initialization' do
      expect(poker_round.table_positions).to eq({1=> 0, 2=> 5, 3=> 10, 4=> 0})
    end

    it 'does not assign nil to player position' do 
      expect(three_player_round.table_positions).to eq({1=> 0, 2=> 5, 3=> 10})
    end
  end

  describe '#order_of_play' do
    it 'assigns [4,1,2,3] for the order of play in a four-player game' do
      poker_round.define_order_of_play(poker_round.players_in_the_round)
      expect(poker_round.order_of_play).to eq([4,1,2,3])
    end

    it 'returns an order of play [3,1,2] for 3 players' do
      three_player_round.define_order_of_play(three_player_round.players_in_the_round)
      expect(three_player_round.order_of_play).to eq([3,1,2])
    end

    it 'returns an order of play [2,1] for 2 players' do
      two_player_round.define_order_of_play(two_player_round.players_in_the_round)
      expect(two_player_round.order_of_play).to eq([2,1])
    end
  end

  describe '#get_ante_from_big_and_small_blind' do
    it 'reduces Player.available_chips by blind amount' do
      poker_round.get_ante_from_big_and_small_blind(poker_round.players_in_the_round)
      active_players = poker_round.players_in_the_round
      expect(active_players[1].available_chips).to eq( 95 )
    end
  end

  describe '#intialize' do
    it 'initializes with the correct default values for attributes' do
      expect(poker_round.opening_pot).to eq( 15 )
    end
  end


end
