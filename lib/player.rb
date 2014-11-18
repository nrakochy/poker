require_relative 'poker_rules'

class Player
  attr_accessor :available_chips, :hand_of_cards, :position_at_the_table, :already_placed_bet, :poker_hand_ranking

  def initialize available_chips = 0, position_at_the_table = 0, hand_of_cards = {}, rules = PokerRules.new
    @available_chips = available_chips
    @hand_of_cards = hand_of_cards
    @position_at_the_table = position_at_the_table
    @already_placed_bet = 0
    #@poker_hand_value = rules.determine_value_of_hand(@hand_of_cards.values)
  end

  def discard card_num
    @hand_of_cards.delete_at(card_num-1)
  end

  def change_position_at_the_table num_at_the_table
    @position_at_the_table == num_at_the_table ? @position_at_the_table = 1 : @position_at_the_table += 1
  end

  def return_position_at_the_table
    @position_at_the_table
  end

  def get_card_from_dealer(card)
    @hand_of_cards << card
  end

  def reveal_hand
    hand_of_cards
  end

  def check
    raise_bet(0)
  end

  def pay_blind blind_amount
    blind = raise_bet(blind_amount)
    @already_placed_bet += blind
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

  def reset_already_placed_bet_at_end_of_betting
    @already_placed_bet = 0
  end

end
