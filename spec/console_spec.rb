require_relative '../lib/console'
require_relative '../lib/fake_io'
require 'pry'

describe Console do
  let(:console) { Console.new(FakeIO.new) }

  describe "all console output methods " do
    it 'validates the last word of each output method' do
      expect(console.welcome_to_five_card_draw.last).to eq("Poker.")
      clear_the_io_output
      big_blind = 100
      expect(console.display_current_configuration(2,0,0, big_blind).last).to eq(big_blind.to_s)
      clear_the_io_output
      expect(console.enter_zero_to_exit_configuration.last).to eq("game.")
      clear_the_io_output
      expect(console.confirm_configuration_choice.last).to eq("specifications.")
      clear_the_io_output
      expect(console.request_which_part_of_the_game_to_config.last).to eq("change.")
      clear_the_io_output
      expect(console.how_many_players_in_the_game.last).to eq("game?")
      clear_the_io_output
      expect(console.set_minimum_amount_to_buy_in.last).to eq("game?")
      clear_the_io_output
      expect(console.cap_maximum_amount_of_buy_in.last).to eq("table?")
      clear_the_io_output
      expect(console.invalid_user_setup_input.last).to eq("0.")
      clear_the_io_output
      expect(console.option_to_discard.last).to eq("as-is.")
      clear_the_io_output
      expect(console.which_card_to_discard(1).last).to eq("discard?")
      clear_the_io_output
      expect(console.discarded_card_summary(1).last).to eq("1.")
      clear_the_io_output
      expect(console.hand_of_cards_summary(['card1', 'card2']).last).to eq("card2 ")
      clear_the_io_output
      expect(console.invalid_card_to_discard_choice.last).to eq("0-3.")
      clear_the_io_output
      expect(console.winner_announcement("player1", ['card1']).last).to eq("player1")
    end
  end

end

def clear_the_io_output
  console.io.output = []
end
