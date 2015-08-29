class Hand

  COMBOS = {
    straight_flush: 8,
    four_of_a_kind: 7,
    full_house: 6,
    flush: 5,
    straight: 4,
    three_of_a_kind: 3,
    two_pair: 2,
    pair: 1
  }

  attr_accessor :cards

  def self.deal_from(deck)
    Hand.new(deck.deal(5))
  end

  def initialize(cards)
    @cards = cards
  end

  def card_values
    @cards.map { |card| card.poker_value }
  end

  def card_suits
    @cards.map { |card| card.suit }
  end

  def straight?
    straight = true
    sorted = card_values.sort
    4.times do |i|
      straight = false if sorted.last - sorted[-2] != 1
      sorted.pop
    end

    straight
  end

end
