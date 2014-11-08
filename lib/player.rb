
class Player
  attr_accessor :available_chips, :hand_of_cards, :position_at_the_table

  def initialize available_chips = 0, position_at_the_table = 0, hand_of_cards = []
    @available_chips = available_chips
    @hand_of_cards = hand_of_cards
    @position_at_the_table = position_at_the_table
  end

  def discard hand_indices
    hand_indices.each{ |index| self.hand_of_cards.delete_at(index) }
    hand_of_cards
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

  def call(current_bet, already_placed = 0)
    amount_needed_to_call = current_bet - already_placed
    self.available_chips -= amount_needed_to_call
    current_bet
  end

  def raise_bet(desired_raise_amount)
    self.available_chips -= desired_raise_amount
    desired_raise_amount
  end

  def call_and_raise(current_bet, desired_raise_amount, already_placed = 0)
    total_bet = current_bet + desired_raise_amount - already_placed
    raise_bet(total_bet)
  end

  def fold
    self.hand_of_cards = []
  end
  
end
