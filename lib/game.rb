require_relative 'game_setup'
require_relative 'poker_round_setup'
require_relative 'poker_round'
require 'pry'

class Game

  def initialize
    @setup = GameSetup.new.set_the_configuration
    @active_players = @setup.players
    @big_blind = @setup.big_blind
  end

  def setup_poker_round
    round_setup = PokerRoundSetup.new(@big_blind, @active_players)
    round_with_seated_players = round_setup.assign_table_position_to_players(round_setup.players_in_the_round)
    round_with_ordered_players = round_setup.define_order_of_play(round_with_seated_players.players_in_the_round)
    round_setup.get_ante_from_big_and_small_blind(round_with_ordered_players.players_in_the_round)
  end

  def play_round round_setup
    poker_round =
      PokerRound.new(round_setup.players_in_the_round, round_setup.table_positions,
                     round_setup.opening_pot)
    poker_round.play
  end

  def play
    setup = setup_poker_round
    play_round(setup)
  end
end


Game.new.play
