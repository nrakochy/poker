class Card
  attr_accessor :rank, :suit, :symbol, :display

  def initialize rank, suit, symbol = nil
    @rank = rank
    @suit = suit
    @symbol = symbol
    @display = show_display
  end

  def show_display
    @display = @rank + @symbol
  end

end

