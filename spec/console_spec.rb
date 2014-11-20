require_relative '../lib/console'
require_relative '../lib/fake_io'

describe Console do
  let(:console) { Console.new(FakeIO.new) }

  describe "all console output methods" do
    it 'validates the first word of each output method' do
      expect(console.welcome_to_five_card_draw.first).to eq("Welcome")
      expect(console.display_current_configuration.first).to eq("Here")
      expect(console.set_big_blind.first).to eq("What")
      expect(console.enter_zero_to_exit_configuration.first).to eq("Enter")
      expect(console.confirm_configuration_choice.first).to eq("Okay.")
      expect(console.request_which_part_of_the_game_to_config.first).to eq("What")
      expect(console.how_many_players_in_the_game.first).to eq("Including")
      expect(console.set_minimum_amount_to_buy_in.first).to eq("What")
      expect(console.cap_maximum_amount_of_buy_in.first).to eq("What")
      expect(console.invalid_user_setup_input.first).to eq("Oops.")
      expect(console.option_to_discard.first).to eq("Please")
      expect(console.which_card_to_discard(1).first).to eq("For")
      expect(console.discarded_card_summary(1).first).to eq("Okay.")
      expect(console.hand_of_cards_summary([]).first).to eq("Your")
      expect(console.invalid_card_to_discard_choice.first).to eq("Oops.")
      expect(console.winner_announcement.first).to eq("Looks")
    end
    
    it 'validates the last word of each output method' do
      expect(console.welcome_to_five_card_draw.last).to eq("Poker.")
      expect(console.display_current_configuration(2,0,0, 100).last).to eq("100")
      expect(console.set_big_blind.last).to eq("round?")
      expect(console.enter_zero_to_exit_configuration.last).to eq("game.")
      expect(console.confirm_configuration_choice.last).to eq("specifications.")
      expect(console.request_which_part_of_the_game_to_config.last).to eq("change.")
      expect(console.how_many_players_in_the_game.last).to eq("game?")
      expect(console.set_minimum_amount_to_buy_in.last).to eq("game?")
      expect(console.cap_maximum_amount_of_buy_in.last).to eq("table?")
      expect(console.invalid_user_setup_input.last).to eq("0.")
      expect(console.option_to_discard.last).to eq("as-is.")
      expect(console.which_card_to_discard(1).last).to eq("discard?")
      expect(console.discarded_card_summary(1).last).to eq("1.")
      expect(console.hand_of_cards_summary(['card1', 'card2']).last).to eq("card2")
      expect(console.invalid_card_to_discard_choice.last).to eq("0-3.")
      expect(console.winner_announcement("player1", ['card1']).last).to eq("player1.")
    end
    
    it 'validates that each argument given to the output method is included in the message' do
      expect(console.which_card_to_discard(1)).to include("#1,")
      expect(console.display_current_configuration(1, 100, 300, 10)).to include("1")
      expect(console.display_current_configuration(1, 100, 300, 10)).to include("100")
      expect(console.display_current_configuration(1, 100, 300, 10)).to include("300")
      expect(console.display_current_configuration(1, 100, 300, 10)).to include("10")
      expect(console.discarded_card_summary(1)).to include("1.")
      expect(console.hand_of_cards_summary(['card1', 'card2'])).to include("card1")
      expect(console.hand_of_cards_summary(['card1', 'card2'])).to include("card2")
      expect(console.winner_announcement(1, ['card1'])).to include("Looks")
    end
  end

end


