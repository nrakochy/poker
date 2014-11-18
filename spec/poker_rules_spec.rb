require_relative '../lib/poker_rules'
require_relative '../lib/deck'

require 'pry'

describe PokerRules do
  let(:poker_rules) { PokerRules.new }
  let(:deck) { Deck.new }

  describe 'pair?' do
    it 'returns true if poker_hand includes pair of same rank' do
      poker_hand = make_hand([['2','Clubs'], ['2', 'Hearts'], ['3', 'Spades'], ['3', 'Hearts'], ['2', 'Diamonds']])
      expect(poker_rules.pair?(poker_hand)).to eq(true)
    end

    it 'returns false if poker_hand does not contain a pair ' do
      poker_hand = make_hand([['2','Clubs'], ['3', 'Hearts'], ['4', 'Spades'], ['10', 'Hearts'], ['K', 'Diamonds']])
      expect(poker_rules.pair?(poker_hand)).to eq(false)
    end
  end

  describe '.three_of_kind?' do
    it 'returns true if poker-hand includes 3 cards of same rank' do
      poker_hand = make_hand([['2','Clubs'], ['2', 'Hearts'], ['3', 'Spades'], ['3', 'Hearts'], ['2', 'Diamonds']])
      expect(poker_rules.three_of_kind?(poker_hand)).to eq(true)
    end

    it 'returns false if poker-hand does not include 3 cards of same rank' do
      poker_hand = make_hand([['2','Clubs'], ['2', 'Hearts'], ['3', 'Spades'], ['3', 'Hearts'], ['10', 'Diamonds']])
      expect(poker_rules.three_of_kind?(poker_hand)).to eq(false)
    end
  end

  describe '.four_of_kind?' do
    it 'returns true if poker_hand includes 4 cards of same rank' do
      poker_hand = make_hand([['2','Clubs'], ['2', 'Hearts'], ['2', 'Spades'], ['3', 'Hearts'], ['2', 'Diamonds']])
      expect(poker_rules.four_of_kind?(poker_hand)).to eq(true)
    end

    it 'returns false if poker_hand does not include 4 cards of same rank' do
      poker_hand = make_hand([['2','Clubs'], ['2', 'Hearts'], ['10', 'Spades'], ['3', 'Hearts'], ['2', 'Diamonds']])
      expect(poker_rules.four_of_kind?(poker_hand)).to eq(false)
    end
  end

  describe '.full_house?' do
    it 'returns true if poker hand includes 3 cards of same rank && two cards of same rank' do
      poker_hand = make_hand([['2','Clubs'], ['2', 'Hearts'], ['2', 'Spades'], ['3', 'Hearts'], ['3', 'Diamonds']])
      expect(poker_rules.full_house?(poker_hand)).to eq(true)
    end

    it 'returns false if poker hand does not include 3 cards of same rank && two cards of same rank' do
      poker_hand = make_hand([['4','Clubs'], ['2', 'Hearts'], ['2', 'Spades'], ['3', 'Hearts'], ['3', 'Diamonds']])
      expect(poker_rules.full_house?(poker_hand)).to eq(false)
    end
  end

  describe '.two_pair?' do
    it 'returns true if poker hand contains two pair of cards with matching rank' do
      poker_hand = make_hand([['4','Clubs'], ['4', 'Hearts'], ['2', 'Spades'], ['3', 'Hearts'], ['3', 'Diamonds']])
      expect(poker_rules.two_pair?(poker_hand)).to eq(true)
    end

    it 'returns false if poker hand does not contain two pairs' do
      poker_hand = make_hand([['4','Clubs'], ['4', 'Hearts'], ['2', 'Spades'], ['3', 'Hearts'], ['9', 'Diamonds']])
      expect(poker_rules.two_pair?(poker_hand)).to eq(false)
    end
  end

  describe '.flush?' do
    it 'returns true if poker hand includes five of the same suit'  do
      poker_hand = make_hand([['4','Clubs'], ['5', 'Clubs'], ['6', 'Clubs'], ['7', 'Clubs'], ['8', 'Clubs']])
      expect(poker_rules.flush?(poker_hand)).to eq(true)
    end

    it 'returns false if poker hand does not include five of the same suit'  do
      poker_hand = make_hand([['4','Hearts'], ['5', 'Clubs'], ['6', 'Clubs'], ['7', 'Clubs'], ['8', 'Clubs']])
      expect(poker_rules.flush?(poker_hand)).to eq(false)
    end
  end

  describe '.consecutive_five_aces_low?' do
    it 'returns true if five numbers are consecutive' do
      expect(poker_rules.consecutive_five_aces_low?(['2','3', '4', '5', '6'])).to eq(true)
    end
    
    it 'returns false if five numbers are not consecutive' do
      expect(poker_rules.consecutive_five_aces_low?(['2','3', '4', '5', '7'])).to eq(false)
    end

    it 'returns false if array includes numbers and face cards that are not consecutive' do 
      expect(poker_rules.consecutive_five_aces_low?(['5', 'J', '8', 'K', 'A'])).to eq(false)
    end

    it 'returns true with an array starting with aces low' do
      expect(poker_rules.consecutive_five_aces_low?(['A', '2', '3', '4', '5'])).to eq(true)
    end

  end

  describe '.consecutive_five_aces_high?' do

    it 'returns true if array includes five consecutive with Aces high' do
      expect(poker_rules.consecutive_five_aces_high?(['10', 'J', 'Q', 'K', 'A'])).to eq(true)
    end

    it 'returns true if array includes five consecutive with only one face card ' do
      expect(poker_rules.consecutive_five_aces_high?(['7', '8', '9', '10', 'J'])).to eq(true)
    end
    

  end

  describe '.straight?' do
    it 'returns true if poker hand includes five consecutive cards'  do
      poker_hand = make_hand([['4','Clubs'], ['5', 'Clubs'], ['6', 'Clubs'], ['7', 'Clubs'], ['8', 'Clubs']])
      expect(poker_rules.straight?(poker_hand, @deck)).to eq(true)
    end
  end

  describe '.flush?' do
    it 'returns false if poker hand does not include five of the same suit'  do
      poker_hand = make_hand([['4','Hearts'], ['5', 'Clubs'], ['6', 'Clubs'], ['7', 'Clubs'], ['8', 'Clubs']])
      expect(poker_rules.flush?(poker_hand)).to eq(false)
    end

    it 'returns true if poker hand includes five of the same suit'  do
      poker_hand = make_hand([['10','Clubs'], ['5', 'Clubs'], ['6', 'Clubs'], ['7', 'Clubs'], ['8', 'Clubs']])
      expect(poker_rules.flush?(poker_hand)).to eq(true)
    end

  end

  describe 'straight_flush?' do
    it 'returns true if poker hash includes five of the same suit in numeric rank order' do
      poker_hand = make_hand([['4','Clubs'], ['5', 'Clubs'], ['6', 'Clubs'], ['7', 'Clubs'], ['8', 'Clubs']])
      expect(poker_rules.straight_flush?(poker_hand, @deck)).to eq(true)
    end

    it 'returns false if poker hand does not include five of the same suit in numeric rank order' do
      poker_hand = make_hand([['4','Clubs'], ['5', 'Diamonds'], ['6', 'Clubs'], ['7', 'Clubs'], ['8', 'Clubs']])
      expect(poker_rules.straight_flush?(poker_hand, @deck)).to eq(false)
    end
  end
end

def find_card rank, suit
  deck.find_card_in_deck(rank, suit)
end

def make_hand rank_suit_set
  hand = []
  rank_suit_set.each{ |card_elements| hand << find_card(card_elements[0], card_elements[1]) }
  hand
end

