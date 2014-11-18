require_relative 'deck'

class Dealer

  attr_reader :current_deck

  def initialize current_deck = Deck.new.full_deck
    @current_deck = current_deck
  end

  def take_card_from_deck random_card
    @current_deck.delete(random_card)
  end

  def get_random_card_from_deck
    @current_deck.sample
  end

  def deal_card
    card = get_random_card_from_deck
    take_card_from_deck(card)
  end

end
