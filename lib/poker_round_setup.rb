require 'pry'
class PokerRoundSetup
  attr_reader :table_positions, :players_in_the_round, :opening_pot, :opening_pot, :big_blind, :order_of_play

  DEALER_BUTTON = 0.0
  NON_BLIND_BETTOR_BUY_IN = 0.0

  def initialize big_blind, players_in_the_round
    @big_blind = big_blind
    @small_blind = big_blind/2
    @opening_pot = @big_blind + @small_blind
    @players_in_the_round = players_in_the_round
    @table_positions = identify_table_betting_positions(players_in_the_round)
    @order_of_play = define_order_of_play(players_in_the_round)
  end
  
  def bettor_seats_at_the_table
    num_of_bettors = players_in_the_round.length
    num_of_bettors > 3 ? bettors = (4..num_of_bettors).to_a : bettors = nil
    bettors
  end

  def define_order_of_play players
    if players.length == 2 
      [2,1]
    elsif players.length == 3
      [3,1,2]
    else
      bettor_seats_at_the_table << 1 << 2 << 3
    end
  end

  def identify_table_betting_positions players
    if players.length > 2
      positions = {
        1 => DEALER_BUTTON,
        2 => @small_blind,
        3 => @big_blind
      }
      seats = bettor_seats_at_the_table
      seats.each{|seat| positions[seat] = NON_BLIND_BETTOR_BUY_IN} if !seats.nil?
      positions
    else
      positions = {
        1 => @small_blind,
        2 => @big_blind
      }
    end
    positions
  end
  
  def assign_table_position_to_players players_in_the_round
    players_in_the_round.each{|player| player.change_position_at_the_table(players_in_the_round.count)}
  end

  def get_ante_from_big_and_small_blind players
    players.each do |player|
      blind =  @table_positions[player.return_position_at_the_table]
      player.pay_blind(blind)
    end
    players
  end



end
