require_relative 'poker_rules'

class Player
  attr_accessor :available_chips, :hand_of_cards, :position_at_the_table, :already_placed_bet, :poker_hand_ranking, :hand_value, :player_num

  NUM_OF_CARDS_IN_HAND = 5

  def initialize available_chips = 0, position_at_the_table = 0, player_num = 0, hand_of_cards = [], hand_value = "High Card"
    @available_chips = available_chips
    @hand_of_cards = hand_of_cards
    @position_at_the_table = position_at_the_table
    @already_placed_bet = 0
    @hand_value = hand_value
    @player_num = player_num
  end

  def discard(card)
    @hand_of_cards.delete(card)
  end

  def find_value_of_hand(current_hand)
    @hand_value = PokerRules.new.determine_value_of_hand(current_hand)
  end

  def count_cards_in_hand
    @hand_of_cards.count
  end

  def find_hand_of_cards
    @hand_of_cards
  end

  def find_card_in_hand display
    @hand_of_cards.find{|card| display == card.display }
  end

  def change_position_at_the_table num_at_the_table
    @position_at_the_table == num_at_the_table ? @position_at_the_table = 1 : @position_at_the_table += 1
  end

  def return_position_at_the_table
    @position_at_the_table
  end

  def get_card_from_dealer(card)
    @hand_of_cards << card
    find_value_of_hand(@hand_of_cards) if count_cards_in_hand == NUM_OF_CARDS_IN_HAND
  end

  def reveal_hand
    hand_of_cards
  end

  def check
    raise_bet(0)
  end

  def pay_blind blind_amount
    raise_bet(blind_amount)
  end

  def call(current_bet)
    amount_needed_to_call = current_bet - @already_placed_bet
    @available_chips -= amount_needed_to_call
    @already_placed_bet += amount_needed_to_call
    @available_chips
  end

  def raise_bet(desired_raise_amount)
    @available_chips -= desired_raise_amount
    @already_placed_bet += desired_raise_amount
    desired_raise_amount
  end

  def call_and_raise(current_bet, desired_raise_amount)
    total_bet = current_bet + desired_raise_amount - @already_placed_bet
    raise_bet(total_bet)
  end

  def fold
    @hand_of_cards = []
  end

  def get_player_number
    @player_num
  end

  def reset_already_placed_bet_at_end_of_the_round
    @already_placed_bet = 0
  end

  def get_pot_from_the_table_for_winning_hand pot
    @available_chips += pot
  end

end
