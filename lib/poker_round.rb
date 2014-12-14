require_relative 'poker_round_setup'
require_relative 'console'
require_relative 'dealer'
require 'pry'

class PokerRound
  attr_reader :pot, :table_positions, :big_blind, :active_players,
    :dealer, :discard_pile

  NUM_OF_CARDS_IN_HAND = 5

  def initialize(active_players, table_positions = [], pot = 15,
                 console = Console.new, rules = PokerRules.new, dealer = Dealer.new)
    @table_positions = table_positions
    @dealer = dealer
    @pot = pot
    @active_players = active_players
    @discard_pile = []
    @current_bet = 0
    @console = console
    @rules = rules
  end

  def play
    deal_hand_of_cards(@active_players)
    each_player_option_to_discard_and_replace_from_dealer(@active_players)
    winning_player = find_winning_hand(@active_players)
    @console.winner_announcement(
    winning_player.get_player_number, winning_player.find_hand_of_cards)
    winning_player.get_pot_from_the_table_for_winning_hand(@pot)
    reset_all_placed_bets_at_end_of_round(@active_players)
  end

  def find_winning_hand(players)
   player_with_winning_hand = {}
    players.each do |player|
      hand_rank_acc_to_poker_rules = @rules.find_rank_of_poker_hand(player.hand_value)
      if player_with_winning_hand.empty? || hand_rank_acc_to_poker_rules < player_with_winning_hand.values.first
        player_with_winning_hand = {}
        player_with_winning_hand[player] = hand_rank_acc_to_poker_rules
      end
    end
    player_with_winning_hand.keys.first
  end

  def add_bet_to_the_pot(current_bet)
    @pot += current_bet
  end

  def discard_from_player_into_discard_pile(generic_player,card)
    @discard_pile << generic_player.discard(card)
  end

  def remove_inactive_players_from_round(players)
    players.each{|player| players.delete(player) if player.hand_of_cards == [] }
  end

  def deal_hand_of_cards players
    NUM_OF_CARDS_IN_HAND.times do |deal|
      players.each do |player|
        card = @dealer.deal_card
        player.get_card_from_dealer(card)
      end
    end
    players
  end

  def each_player_check_bet_fold active_players, current_bet
    active_players.each{ |player| player.make_betting_move(current_bet) }
  end

  def each_player_option_to_discard_and_replace_from_dealer players
    players.each do |player|
      display_cards = make_cards_display(player.hand_of_cards)
      @console.hand_of_cards_summary(display_cards)
      @console.best_hand_summary(player.find_value_of_hand(player.hand_of_cards))
      input = allow_user_choice_to_discard
      if input > 0
        request_which_cards_to_discard_from_player_and_get_replacements_from_dealer(input, player, display_cards) 
      end
      display_cards = make_cards_display(player.hand_of_cards)
      @console.confirm_discard_and_new_cards_added
      @console.hand_of_cards_summary(display_cards)
      @console.best_hand_summary(player.find_value_of_hand(player.hand_of_cards))
    end
  end

  def make_cards_display hand_of_cards
    display = {}
    card_num = 1
    hand_of_cards.each do |card|
      display[card_num] = card.show_display
      card_num += 1
    end
    display
  end

  def valid_user_choice? given_input
    given_input >= 0 && given_input <= 3
  end

  def allow_user_choice_to_discard
    valid_user_choice = false
    input = nil
    while valid_user_choice == false
      @console.option_to_discard
      input = @console.get_input.to_i
      valid_user_choice?(input) ? valid_user_choice = true : @console.invalid_input
    end
    input
  end

  def deal_more_cards_after_discard generic_player
    while generic_player.count_cards_in_hand < NUM_OF_CARDS_IN_HAND
      card = @dealer.deal_card
      generic_player.get_card_from_dealer(card)
    end
  end

  def request_which_cards_to_discard_from_player given_input, generic_player, numbered_cards
    discard_counter = 1
    while given_input > 0
      @console.which_card_to_discard(discard_counter)
      card_num_to_discard = @console.get_input.to_i
      discard_card_display_symbol = numbered_cards[card_num_to_discard]
      card_to_discard = generic_player.find_card_in_hand(discard_card_display_symbol)
      discard_from_player_into_discard_pile(generic_player, card_to_discard)
      given_input -= 1
      discard_counter += 1
      @console.discarded_card_summary(discard_card_display_symbol)
    end
  end

  def request_which_cards_to_discard_from_player_and_get_replacements_from_dealer given_input, generic_player, numbered_cards
    request_which_cards_to_discard_from_player(given_input, generic_player, numbered_cards)
    deal_more_cards_after_discard(generic_player)
  end

  def reset_all_placed_bets_at_end_of_round(players)
    players.each{ |player| player.reset_already_placed_bet_at_end_of_the_round }
  end

end
