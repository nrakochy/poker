require_relative 'player'
require_relative 'poker_rules'
require_relative 'console'
require 'pry'

class GameSetup
  attr_reader :players, :player_count, :table_positions

  YES = 'Y'

  def initialize(
    player_count = 2, big_blind = 10, minimum_amount_to_buy_in = 100, 
    table_positions = [], console = Console.new)

    @players = []
    @player_count = player_count
    @big_blind = big_blind
    @minimum_buy_in = minimum_amount_to_buy_in
    @maximum_buy_in = minimum_amount_to_buy_in
    @table_positions = table_positions
    @console = console
  end

  def set_the_configuration
    setup_game if ready_for_game?
  end

  def ready_for_game?
    ready_for_game = false
    player_choice = choose_yes_to_config_else_default_settings
    ready_for_game = true if player_choice != YES
    while ready_for_game == false
      ready_for_game = choose_poker_game_config
    end
    ready_for_game
  end

  def setup_game
    create_players
    seats_at_the_table
    self
  end

  def create_players players = []
    seat_counter = 0
    @player_count.times do |create_player|
      players << create_single_player(@minimum_buy_in, seat_counter)
      seat_counter += 1
    end
    @player_count = players.count
    @players = players
  end

  def create_single_player initial_buy_in, table_position
    Player.new(initial_buy_in, table_position)
  end

  def seats_at_the_table
    @table_positions = (0..@player_count - 1).to_a
  end

  def choose_poker_game_config
    @console.confirm_config_choice
    exit_game_configuration_and_ready_for_game = false
    while exit_game_configuration_and_ready_for_game == false
      @console.display_current_configuration
      @console.request_which_part_of_the_game_to_config
      @console.enter_zero_to_exit_configuration
      user_input = @console.user_input.to_i
      if user_input == 0
        exit_game_configuration_and_ready_for_game = true
      else
        change_one_of_game_config_options(user_input)
      end
    end
    exit_game_configuration_and_ready_for_game
  end

  def change_one_of_game_config_options(given_input)
    config_options = {
      1 => get_number_of_players,
      2 => set_minimum_amount_to_buy_in,
      3 => cap_maximum_amount_of_buy_in,
      4 => set_big_blind
    }
    config_options[given_input]
    given_input
  end

  def get_number_of_players
    @console.how_many_players_in_the_game
    num_of_players = @console.get_input.to_i
    @player_count = num_of_players if valid_user_input?(num_of_players)
  end

  def set_minimum_amount_to_buy_in
    @console.set_minimum_amount_to_buy_in
    minimum = @console.get_input.to_i
    @minimum_buy_in = minimum if valid_user_input?(minimum)
  end

  def cap_maximum_amount_of_buy_in
    @console.cap_maximum_amount_of_buy_in
    max = @console.get_input.to_i
    @maximum_buy_in = max if valid_user_input?(max)
  end

  def set_big_blind
    @console.set_big_blind
    blind = @console.get_input.to_i
    @big_blind = blind if valid_user_input?(blind)
  end

  def choose_yes_to_config_else_default_settings
    @console.choose_yes_to_config_else_default_settings(@players)
    @console.get_input.upcase
  end

  def valid_user_input? given_input
    input_is_good = validate_user_input?(given_input)
    counter = 0
    while input_is_good = false || counter < 5
      invalid_user_setup_input
      counter += 1
      new_input = @console.get_input
      input_is_good = validate_user_input?(new_input)
    end
    input_is_good
  end

  def validate_user_input? input
    input != 0
  end

  def invalid_user_setup_input
    @console.invalid_user_setup_input
  end

end
