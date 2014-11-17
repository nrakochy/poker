require_relative 'card'
require 'pry'
class Deck

  attr_accessor :full_deck
  
  def initialize full_deck = {}
    @full_deck = full_deck
  end

  def make_deck_of_cards full_deck = {}
    numbers_in_deck = (2..10).to_a
    rank_values = (numbers_in_deck.map{|num| num.to_s} + ['J', 'Q', 'K', 'A'])
    suits = [["Clubs", "\u2667".chr], ["Diamonds", "\u2662".chr], ["Hearts", "\u2661".chr], ["Spades", "\u2664".chr]]
    card_id = 1
    suits.each{|suit| rank_values.each{|rank| @full_deck[card_id] = Card.new(rank, suit[0], suit[1]); card_id += 1}}
    @full_deck
  end
  
  def find_card_in_deck card_id
    @full_deck[card_id]
  end


end
