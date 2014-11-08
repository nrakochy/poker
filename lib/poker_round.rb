require_relative 'poker_round_setup'
require 'pry'

class PokerRound
  attr_reader :pot, :table_positions, :big_blind, :active_players

  def initialize table_positions, order_of_play, pot = 15, active_players
    @table_positions = table_positions
    @order_of_play = order_of_play
    @pot = pot
    @active_players = active_players
    @discard_pile = []
  end
  
  def add_current_bet_to_the_pot current_bet
    @pot += current_bet
  end

  def add_card_to_discard_pile card
    self.discard_pile << card
  end

  def remove_player_from_round
    active_players.each{|player| active_players.delete(player) if player.hand_of_cards == [] }
  end

end
