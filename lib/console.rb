require_relative 'board_io'

class Console

  def initialize io = BoardIO.new
    @io = io
  end

  def welcome_to_five_card_draw
    @io.print_output "Welcome to Five Card Draw Poker."
  end

  def choose_yes_to_config_else_default_settings players, minimum_amount_to_buy_in, maximum_amount_to_buy_in, big_blind
    @io.print_output
      "Do you want to customize the game setup or just get to playing?\n" +
      display_current_configuration(players, minimum_amount_to_buy_in, maximum_amount_to_buy_in, big_blind) +
      "Enter Y for customization. Enter anything else to start the game."
  end

  def display_current_configuration players, minimum_amount_to_buy_in, maximum_amount_to_buy_in, big_blind
    @io.print_output
     "Here is the current configuration:\n
        1. Number of players:          #{num_of_players}\n
        2. Minimum amount to buy-in :  #{minimum_amount_to_buy_in}\n
        3. Maximum amount of buy-in :  #{maximum_amount_to_buy_in}\n
        4. Big blind:                  #{big_blind}\n"
  end

  def enter_zero_to_exit_configuration
    @io.print_output "Enter 0 to exit configuration and start the game."
  end

  def confirm_configuration_choice
    @io.print_output "Okay. You chose to customize the game specifications."
  end

  def request_which_part_of_the_game_to_config
    @io.print_output
    "What would you like to change?\n
    Enter 1-4 to choose a category to change."
  end

  def how_many_players_in_the_game
    @io.print_output "Including yourself, how many players would you like to have in the game?"
  end

  def set_minimum_amount_to_buy_in
    @io.print_output "What is the minimum amount of money needed to join the game?"
  end

  def set_big_blind
    @io.print_output "What is the big blind ante needed to open the betting in each round?"
  end

  def cap_maximum_amount_of_buy_in
    @io.print_output "What is the most money that a betting player can bring to the table?"
  end

  def invalid_user_setup_input
    @io.print_output "Oops. Looks like you entered the wrong value.
     You need to enter a positive number that is greater than 0."
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

  def invalid_card_to_discard_choice
    @io.print_output "Oops. Looks like you entered a wrong value. You need to enter a number 0-3."
  end

  def winner_announcement player, player_best_hand
    @io.print_output "Looks like we have a winner. 
    The winning hand is #{player_best_hand}, held by #{player}."
  end

  def user_input
    @io.get_input
  end
end
