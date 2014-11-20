require_relative '../lib/console'
require_relative '../lib/fake_io'

describe Console do
  let(:console) { Console.new(FakeIO.new) }

  describe "all console output methods " do
    it 'validates that each argument given to the output method is included in the message' do
      expect(console.which_card_to_discard(1)).to include("#1,")
      clear_the_io_output
      expect(console.display_current_configuration(1, 100, 300, 10)).to include("1")
      expect(console.display_current_configuration(1, 100, 300, 10)).to include("100")
      expect(console.display_current_configuration(1, 100, 300, 10)).to include("300")
      expect(console.display_current_configuration(1, 100, 300, 10)).to include("10")
      clear_the_io_output
      expect(console.discarded_card_summary(1)).to include("1.")
      clear_the_io_output
      expect(console.hand_of_cards_summary(['card1', 'card2'])).to include("card1")
      expect(console.hand_of_cards_summary(['card1', 'card2'])).to include("card2")
      clear_the_io_output
      expect(console.winner_announcement(1, ['card1'])).to include("Looks")
    end
  end

end

def clear_the_io_output
  console.io.output = []
end
