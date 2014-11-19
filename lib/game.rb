class Game

  def initialize
    @setup = GameSetup.new.set_the_configuration
    @active_players = setup.players
    @big_blind = setup.big_blind
  end

  def setup_round big_blind, players
    setup = PokerRoundSetup.new(big_blind, players)
    seated_players = setup.assign_table_position_to_players(players)
    ordered_players = setup.define_order_of_play(seated_players)
    paying_players = setup.get_ante_from_big_and_small_blind(ordered_players)
    setup.players_in_the_round = paying_players
    setup
  end

  def play_round setup, dealer
    poker_round = PokerRound.new(setup.table_positions, setup.order_of_play, setup.opening_pot, setup.players_in_the_round )
    poker_round.play
  end

  def play
  end


end
