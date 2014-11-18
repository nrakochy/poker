require 'pry'
require_relative 'deck'

class PokerRules

    def initialize deck = Deck.new
      @poker_hand_ranking = {
          1 => "Straight Flush",
          2 => "Four of a Kind",
          3 => "Full House",
          4 => "Flush",
          5 => "Straight",
          6 => "Three of a Kind",
          7 => "Two Pair",
          8 => "Pair",
          9 => "High Card"
        }
      @deck = deck
    end

  def find_rank_of_poker_hand value_of_hand_of_cards
    @poker_hand_ranking.key(value_of_hand_of_cards)
  end

  def determine_value_of_hand poker_hand
    full_deck = @deck
    return "High Card" if poker_hand.empty?

    rank = nil
    case
    when straight_flush?(poker_hand, full_deck)
      rank = "Straight Flush"
    when four_of_kind?(poker_hand)
      rank = "Four of a Kind"
    when full_house?(poker_hand)
      rank = "Full House"
    when flush?(poker_hand)
      rank = "Flush"
    when straight?(poker_hand, full_deck)
      rank = "Straight"
    when three_of_kind?(poker_hand)
      rank = "Three of a Kind"
    when two_pair?(poker_hand)
      rank = "Two Pair"
    when pair?(poker_hand)
      rank = "Pair"
    else
      rank = "High Card"
    end
    rank
  end

  def pair? poker_hand
    poker_hash = count_face_value(poker_hand)
    poker_hash.has_value?(2) && !two_pair?(poker_hand)
  end

  def three_of_kind? poker_hand
    poker_hash = count_face_value(poker_hand)
    poker_hash.has_value?(3)
  end

 def four_of_kind? poker_hand
    poker_hash = count_face_value(poker_hand)
    poker_hash.has_value?(4)
 end

 def full_house? poker_hand
    poker_hash = count_face_value(poker_hand)
    poker_hash.has_value?(3) && poker_hash.has_value?(2)
 end

 def two_pair? poker_hand
    poker_hash = count_face_value(poker_hand)
    counter = []
    poker_hash.each_value{|value| counter << value if value == 2}
    counter.length == 2 && !full_house?(poker_hand)
 end


#COUNT SUITS
  def flush? poker_hand
    poker_hash = count_suits(poker_hand)
    poker_hash.has_value?(5)
  end

  def straight_flush? poker_hand, full_deck
    flush?(poker_hand) && straight?(poker_hand, full_deck)
  end

  def straight? poker_hand, full_deck
    hand_arr = []
    poker_hand.each{|card| hand_arr.push(card.rank)}
    hand_arr.sort
    consecutive_five_aces_high?(hand_arr) && unique_five?(hand_arr) || consecutive_five_aces_low?(hand_arr) && unique_five?(hand_arr)
  end
  
  def unique_five? hand_ranks
    hand_ranks.uniq.length >= 5
  end

  def consecutive_five_aces_low? hand_ranks
    deck_numbers = ((2..10).to_a.map{|num| num.to_s})
    deck_numbers = deck_numbers.unshift('A')
    if hand_ranks.include?('A')
      hand_ranks.delete('A')
      sorted_hand  = hand_ranks.unshift('A')
    else sorted_hand = hand_ranks
    end
    lowest_card = sorted_hand.first

    starting_point = deck_numbers.index(lowest_card)
    straight = deck_numbers[starting_point, 5] 
    hand_ranks == straight
  end

  def consecutive_five_aces_high? hand_ranks
    face_cards = ['J', 'Q', 'K', 'A']
    deck_ranks = ((2..10).to_a.map{|num| num.to_s}) + face_cards
    included = []
    face_cards.each do |face_card|
      if hand_ranks.include?(face_card)
      included << face_card
      hand_ranks.delete(face_card)
      end
    end
    included.each{|included_face| hand_ranks << included_face}
    lowest_card = hand_ranks.first
    starting_point = deck_ranks.index(lowest_card)
    straight = deck_ranks[starting_point, 5]
    hand_ranks == straight
  end

  private

  def count_suits poker_hand
    poker_hash = Hash.new(0)
    poker_hand.each{|card| poker_hash[card.suit] += 1}
    poker_hash
  end

  def count_face_value poker_hand
    poker_hash = Hash.new(0)
    poker_hand.each{|card| poker_hash[card.rank] += 1}
    poker_hash
  end
end

