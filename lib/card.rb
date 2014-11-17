class Card
  attr_accessor :rank, :suit, :symbol

  def initialize rank, suit, symbol = nil
    @rank = rank
    @suit = suit
    @symbol = symbol
  end

end

