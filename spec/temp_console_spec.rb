require_relative '../lib/console'
require_relative '../lib/fake_io'
require 'pry'

describe Console do
  let(:console) { Console.new(FakeIO.new) }

  describe "all console output methods " do
    it 'validates the first word of each output method' do
      expect(console.welcome_to_five_card_draw.first).to eq("Welcome")
      clear_the_io_output
      expect(console.display_current_configuration.first).to eq("Here")
      clear_the_io_output
      expect(console.enter_zero_to_exit_configuration.first).to eq("Enter")
      clear_the_io_output
      expect(console.confirm_configuration_choice.first).to eq("Okay.")
      clear_the_io_output
      expect(console.request_which_part_of_the_game_to_config.first).to eq("What")
      clear_the_io_output
      expect(console.how_many_players_in_the_game.first).to eq("Including")
      clear_the_io_output
      expect(console.set_minimum_amount_to_buy_in.first).to eq("What")
      clear_the_io_output
      expect(console.cap_maximum_amount_of_buy_in.first).to eq("What")
      expect(console.invalid_user_setup_input.first).to eq("Oops.")
      clear_the_io_output
      expect(console.option_to_discard.first).to eq("Please")
      clear_the_io_output
      expect(console.which_card_to_discard(1).first).to eq("For")
      clear_the_io_output
      expect(console.discarded_card_summary(1).first).to eq("Okay.")
      clear_the_io_output
      expect(console.hand_of_cards_summary([]).first).to eq("Your")
      clear_the_io_output
      expect(console.invalid_card_to_discard_choice.first).to eq("Oops.")
      clear_the_io_output
      expect(console.winner_announcement.first).to eq("Looks")
      clear_the_io_output
    end
  end

end

def clear_the_io_output
  console.io.output = []
end
