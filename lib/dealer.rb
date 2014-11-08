require_relative 'deck'

class Dealer

  #DEPENDENCY ISSUE WITH DEAL METHODS?

  attr_reader :current_deck

  NUM_OF_CARDS_IN_HAND = 5

  def initialize current_deck = Deck.new.full_deck
    @current_deck = current_deck
  end

  def take_card_from_deck
    card = current_deck.sample
    current_deck.delete(card)
  end

  def deal_hand active_players
    NUM_OF_CARDS_IN_HAND.times do |deal|
      active_players.each{ |player| player << take_card_from_deck }
    end
  end

  def deal_card player_hand
    player_hand << take_card_from_deck
  end

end
