require_relative 'card'
class Deck  	

  attr_accessor :full_deck, :current_deck
  
  def initialize full_deck = []
    @full_deck = make_deck_of_cards
  end

  def make_deck_of_cards full_deck = []
    numbers_in_deck = (2..10).to_a
    rank_values = (numbers_in_deck.map{|num| num.to_s} + ['J', 'Q', 'K', 'A'])
    suits = [["Clubs", "\u2667".chr], ["Diamonds", "\u2662".chr], ["Hearts", "\u2661".chr], ["Spades", "\u2664".chr]]
    suits.each{|suit| rank_values.each{|rank| full_deck << Card.new(rank, suit[0], suit[1])}}
    full_deck
  end

end
