require_relative 'game_io'
require 'pry'

class Console
  attr_reader :io

  def initialize io = GameIO.new
    @io = io
  end

  def welcome_to_five_card_draw
    @io.print_output "\n--WELCOME TO FIVE CARD DRAW POKER--\n"
  end

  def choose_yes_to_config_else_default_settings(num_of_players = 2, minimum_amount_to_buy_in =100, maximum_amount_to_buy_in = 100, big_blind = 10)
    @io.print_output(
      (welcome_to_five_card_draw).to_s +
      "Do you want to customize the game setup or just get to playing?\n" +
      (display_current_configuration(num_of_players, minimum_amount_to_buy_in, maximum_amount_to_buy_in, big_blind)).to_s +
      "Enter Y for customization. Enter anything else to start the game.")
  end

  def display_current_configuration(num_of_players = 2, minimum_amount_to_buy_in = 100, maximum_amount_to_buy_in = 100, big_blind= 10)
    @io.print_output(
     "Here is the current configuration:\n
        1. Number of players:          #{num_of_players}\n
        2. Minimum amount to buy-in :  #{minimum_amount_to_buy_in}\n
        3. Maximum amount of buy-in :  #{maximum_amount_to_buy_in}\n
        4. Big blind:                  #{big_blind}\n")
  end

  def enter_zero_to_exit_configuration
    @io.print_output("    Enter 0 at any time to exit configuration and start the game.")
  end

  def confirm_configuration_choice
    @io.print_output("Okay. You chose to customize the game specifications.")
  end

  def request_which_part_of_the_game_to_config
    @io.print_output(
    "What would you like to change?\n
    Enter 1-4 to choose a category from above to change.")
  end

  def how_many_players_in_the_game
    @io.print_output(
      "Including yourself, how many players would you like to have in the game?")
  end

  def set_minimum_amount_to_buy_in
    @io.print_output(
      "What is the minimum amount of money needed to join the game?")
  end

  def set_big_blind
    @io.print_output(
      "What is the big blind ante needed to open the betting in each round?")
  end

  def cap_maximum_amount_of_buy_in
    @io.print_output(
      "What is the most money that a betting player can bring to the table?")
  end

  def invalid_user_setup_input
    @io.print_output("Oops. Looks like you entered the wrong value.
     You need to enter a positive number that is greater than 0.")
  end

  def option_to_discard
    @io.print_output(
      "\nPlease enter how many cards you want to discard from your hand.\nYou can choose up to 3 cards to discard.\n")
  end

  def which_card_to_discard card_counter
    @io.print_output(
      "For card ##{card_counter}, which card do you want to discard?")
  end

  def discarded_card_summary(card_display)
    @io.print_output("Okay. You discarded #{card_display}.")
  end

  def hand_of_cards_summary(cards_to_display)
   @io.print_output("Here is your hand of cards:\n").to_s +
   display_cards(cards_to_display).to_s
  end

  def display_cards(cards_to_display)
    cards_to_display.each do |card_num, card_visual|
      @io.print_output(
      "Card ##{card_num} is #{card_visual}").to_s
    end
  end


  def best_hand_summary(best_hand)
    @io.print_output("\nRight now, your best hand is the #{best_hand}")
  end

  def confirm_discard_and_new_cards_added
    @io.print_output("Okay. Here we go. This is what your hand is going to be.")
  end

  def invalid_card_to_discard_choice
    @io.print_output(
      "Oops. Looks like you entered a wrong value.
      You need to enter a number 0-3.")
  end

  def winner_announcement player = 0, cards_to_display
    @io.print_output("Looks like we have a winner. The winning hand is " +
    display_cards(cards_to_display).to_s + "held by player##{player}.")
  end

  def get_input
    @io.get_input
  end
end
