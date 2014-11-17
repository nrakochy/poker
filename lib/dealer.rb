require_relative 'deck'

class Dealer

  #DEPENDENCY ISSUE WITH DEAL METHODS?

  attr_reader :current_deck

  def initialize current_deck = Deck.new.make_deck_of_cards
    @current_deck = current_deck
  end

  def take_card_from_deck
    card = @current_deck.sample
    @current_deck.delete(card)
  end

  def deal_card
    take_card_from_deck
  end

end
