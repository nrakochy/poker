require_relative 'board_io'

class Console

  def initialize io = BoardIO.new
    @io = io
  end

  def option_to_discard
    @io.print_output "Please enter how many cards you want to discard from your hand.\n   You can choose up to 3 cards to discard.\n    Enter anything other than 1-3 to keep your hand as is."
  end

  def which_card_to_discard card_counter
    @io.print_output "For card ##{card_counter}, which card do you want to discard?"
  end

  def discarded_card_summary(card)
    @io.print_output "Okay. You discarded #{card}"
  end

  def hand_of_cards_summary(hand_of_cards)
    @io.print_output "Your current hand of cards: #{hand_of_cards}"
  end

  def invalid_input
    @io.print_output "Oops. Looks like you entered a wrong value. You need to enter a number 0-3."
  end

  def winner_announcement player, player_best_hand
    @io.print_output "Looks like we have a winner. The winning hand is #{player_best_hand}, held by #{player}."
  end

  def user_input
    @io.get_input
  end
end
