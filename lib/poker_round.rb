require_relative 'poker_round_setup'
require_relative 'console'

require 'pry'

class PokerRound
  attr_reader :pot, :table_positions, :big_blind

  NUM_OF_CARDS_IN_HAND = 5

  def initialize(active_players, dealer, table_positions = [], pot = 15,  console = Console.new, rules = PokerRules.new)
    @table_positions = table_positions
    @dealer = dealer
    @pot = pot
    @active_players = active_players
    @discard_pile = []
    @current_bet = 0
    @console = console
    @rules = rules
  end

  def play_round
    deal_hand_of_cards(@active_players)
    each_player_option_to_discard(@active_players)
    winning_hand = find_winning_hand(@active_players)
    @console.winner_announcement(
      winning_hand[player],
      winning_hand.key(player)
    )
  end

  def find_winning_hand(players)
   winning_hand = {}
    players.each do |player|
      rank = @rules.find_rank_of_poker_hand(player.poker_hand_value)
      winning_hand[player] = player.poker_hand_value if rank > winning_hand[player]
    end
    winning_hand
  end

  def add_bet_to_the_pot(current_bet)
    @pot += current_bet
  end

  def add_card_to_discard_pile(card)
    @discard_pile << card
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
  end

  def each_player_check_bet_fold active_players, current_bet
    active_players.each{ |player| player.make_move(current_bet) }
  end

  def each_player_option_to_discard players
    players.each do |player|
      allow_user_choice_to_discard
      request_which_cards_to_discard_from_player_and_get_replacements_from_dealer(input, player) if input > 0
      @console.hand_of_cards_summary
    end
  end

  def valid_user_choice? given_input
    given_input >= 0 && given_input <= 3
  end

  def allow_user_choice_to_discard
    valid_user_choice = false
    input = nil
    while valid_user_choice == false
      @console.option_to_discard
      input = @console.user_input.to_i
      valid_user_choice?(input) ? valid_user_choice = true : @console.invalid_input
    end
    input
  end

  def deal_more_cards_after_discard generic_player
    while generic_player.hand_of_cards.count < NUM_OF_CARDS_IN_HAND
      card = @dealer.deal_card
      generic_player.get_card_from_dealer(card)
    end
  end

  def request_which_cards_to_discard_from_player given_input, generic_player
    while given_input > 0
      counter = 1
      card_to_discard = @console.which_card_to_discard(counter)
      @discard_pile << generic_player.discard(card_to_discard)
      given_input -= 1
      counter += 1
      @console.discared_card_summary
    end
  end

  def request_which_cards_to_discard_from_player_and_get_replacements_from_dealer given_input, generic_player
    request_which_cards_to_discard_from_player(given_input, generic_player)
    deal_more_cards_after_discard(generic_player)
  end

end
