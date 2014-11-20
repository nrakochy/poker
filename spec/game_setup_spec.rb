require_relative '../lib/game_setup'
require_relative '../lib/console'
require_relative '../lib/fake_io'

describe GameSetup do
  let(:console) { Console.new(FakeIO.new) }
  let(:game_setup) { GameSetup.new(
    @player_count, @big_blind, @minimum_amount_to_buy_in, @table_positions, console) }

  let(:game_setup_five_player) { GameSetup.new(
    @player_count5, @minimum_amount_to_buy_in, @table_positions, console)}


  before :each do
    @player_count = 2
    @big_blind = 10
    @minimum_amount_to_buy_in = 100
    @table_positions = []
    @player_count5 = 5
  end

  describe '#setup_game' do
    it 'creates the Player objects that are not instantiated upon initialization' do
      expect(game_setup.players.count).to eq(0)
      game_setup.setup_game
      expect(game_setup.players.count).to eq(2)
    end
  end

  describe "#create_players" do
    it 'creates an array of Player objects' do
      game_setup.create_players
      expect(game_setup.players.class).to eq(Array)
    end

    it 'returns 2 players by default' do
      game_setup.create_players
      expect(game_setup.players.count).to eq(2)
    end

    it 'sets the Player available_chips attribute to the minimum_amount_to_buy_in by default' do
      game_setup.create_players
      expect(game_setup.players.first.available_chips).to eq(@minimum_amount_to_buy_in)
    end

    it 'assigns Player objects to different seats at the table' do
      game_setup.create_players
      expect(game_setup.players.first.position_at_the_table).to eq(0)
      expect(game_setup.players[1].position_at_the_table).to eq(1)
    end

    it 'creates number of Players according to @player_count attribute' do
      game_setup_five_player.create_players
      expect(game_setup_five_player.player_count).to eq(5)
    end
  end

  describe '#create_single_player' do
    it 'instantiates a Player object' do
      expect(game_setup.create_single_player(100, 0).class).to eq(Player)
    end
  end

end


